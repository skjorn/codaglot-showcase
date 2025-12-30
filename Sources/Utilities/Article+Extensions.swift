import Ignite

extension Article {
    func postprocessedText(
        in programmingLanguage: ProgrammingLanguage,
        stripToParagraphs: Bool = false,
        generateTOCFrom subTopics: [SubTopic] = []
    ) -> String {
        let postprocessor = ArticlePostprocessor(article: self)
        return postprocessor.postprocess(
            articleHTML: text,
            programmedIn: programmingLanguage,
            stripToParagraphs: stripToParagraphs,
            generateTOCFrom: subTopics
        )
    }
}
