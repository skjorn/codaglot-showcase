import Ignite
import SwiftSoup

@MainActor
final class ArticlePostprocessor {
    let article: Article

    init(article: Article) {
        self.article = article
    }

    func postprocess(
        articleHTML: String,
        programmedIn language: ProgrammingLanguage,
        stripToParagraphs: Bool = false,
        generateTOCFrom subTopics: [SubTopic] = []
    ) -> String {
        let document = try! SwiftSoup.parseBodyFragment(articleHTML)
        document.outputSettings().prettyPrint(pretty: false)

        if stripToParagraphs {
            removeNonParagraphs(in: document)
        }
        replaceLocalLinks(in: document, given: language)
        if !subTopics.isEmpty {
            generateTOC(in: document, from: subTopics)
        }

        return try! document.body()!.html()
    }

    private func generateTOC(in document: SwiftSoup.Document, from subTopics: [SubTopic]) {
        let navComponent = InlineSubtopicNavigation(subTopics: subTopics)
        let htmlString = navComponent.htmlString
        let h1Element = document.body()!.getChildNodes().first {
            guard let element = $0 as? Element else { return false }
            return element.tagName().lowercased() == "h1"
        }
        try! h1Element?.after(htmlString)
    }

    private func removeNonParagraphs(in document: SwiftSoup.Document) {
        for node in document.body()!.getChildNodes() {
            if let element = node as? Element, element.tagNameNormal() == "p" {
                continue
            }
            try! node.remove()
        }
    }

    private func replaceLocalLinks(in document: SwiftSoup.Document, given language: ProgrammingLanguage) {
        let links = try! document.select("a")
        for link in links {
            guard let href = link.href, isLocalLink(href: href) else {
                continue
            }
            updateLocalLink(href: href, element: link, programmingLanguage: language)
        }
    }

    private func isLocalLink(href: String) -> Bool {
        href.starts(with: "link:")
    }

    private func updateLocalLink(href: String, element: Element, programmingLanguage: ProgrammingLanguage) {
        let hrefWithoutMarker = String(href.drop(while: { $0 != ":" }).dropFirst())
        let fragmentIndex = hrefWithoutMarker.firstIndex(of: "#")
        let fragment = fragmentIndex.map { String(hrefWithoutMarker.suffix(from: $0)) }

        // Find matching article and validate
        let hrefPath = (fragmentIndex.map { String(hrefWithoutMarker[..<$0]) } ?? hrefWithoutMarker).lowercased()
        let targets = programmingLanguage.routableNodes
        let matches = targets.filter { $0.path.hasSuffix(hrefPath) }
        guard !matches.isEmpty else {
            fatalError("Article for local link '\(hrefPath)' not found! Referenced from article '\(article.path)'")
        }
        guard matches.count == 1, let theTarget = matches.first else {
            fatalError("""
                Multiple articles match the local link '\(hrefPath)' in article '\(article.path)'!
                Potential candidates:
                \(matches.map({ "- \($0.path)" }).joined(separator: "\n"))
                """)
        }

        // Update the link
        let targetHref = [theTarget.path, fragment].compactMap({ $0 }).joined()
        let label = theTarget.name
        try! element.text(label)
        try! element.attr("href", targetHref)
    }
}

private extension Element {
    var href: String? {
        guard let hrefValue = try? attr("href"), !hrefValue.isEmpty else {
            return nil
        }
        return hrefValue
    }
}
