import Foundation
import Ignite
import SwiftSoup

class HTMLAnalyzer {
    struct Heading {
        let text: String
        let level: Int
        let anchorName: String?
    }

    let html: String

    init(html: String) {
        self.html = html
    }

    @MainActor
    convenience init(article: Article) {
        self.init(html: article.text)
    }

    func headings() -> [Heading] {
        let document = try! SwiftSoup.parseBodyFragment(html)
        let headings = try! document.select("h1, h2")
        return headings.map(Heading.init)
    }
}

private extension HTMLAnalyzer.Heading {
    init(from element: Element) {
        let tagName = element.tagName().lowercased()
        let level = switch tagName {
            case "h1": 1
            case "h2": 2
            default: fatalError("Tag name <\(tagName)> doesn't match expected H1 or H2")
        }

        let text = try! element.text()
        let anchorName = try! element
            .children()
            .filter { $0.tagName() == "a" }
            .first?
            .attr("name")

        self.init(text: text, level: level, anchorName: anchorName)
    }
}
