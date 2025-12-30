import Ignite

final class EnrichedArticleRenderer: ArticleRenderer {
    let removeTitleFromBody: Bool

    private(set) var title = ""
    private(set) var description = ""
    private(set) var body = ""

    init(markdown: String, removeTitleFromBody: Bool) {
        self.removeTitleFromBody = false

        let preprocessedMarkdown = preprocessMarkdown(markdown: markdown)
        convertMarkdownToHTML(markdown: preprocessedMarkdown, removeTitleFromBody: false)
    }

    private func preprocessMarkdown(markdown: String) -> String {
        var preprocessor = MarkdownPreprocessor()
        return preprocessor.visit(markdown: markdown)
    }

    private func convertMarkdownToHTML(markdown: String, removeTitleFromBody: Bool) {
        let markdownToHTML = MarkdownToHTML(markdown: markdown, removeTitleFromBody: removeTitleFromBody)
        title = markdownToHTML.title
        description = markdownToHTML.description
        body = markdownToHTML.body
    }
}
