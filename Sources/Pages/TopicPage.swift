import Ignite

/// The content is generated from markdown files in the Content folder. This only provides layout.
struct TopicPage: ArticlePage {
    
    @Environment(\.articles) var allArticles
    let contentStructureProvider: ContentStructureProvider
    
    var layout: TopicLayout {
        let topicAddress = resolveCurrentAddress()
        return TopicLayout(
            topicAddress: topicAddress,
            preamble: preambleFor(topicAddress: topicAddress)
        )
    }
    
    @HTMLBuilder
    var body: some HTML {
        let topicAddress = resolveCurrentAddress()
        Text(
            article.postprocessedText(
                in: resolveProgrammingLanguage(),
                generateTOCFrom: topicAddress.topic?.subTopics ?? []
            )
        )
    }

    private func resolveProgrammingLanguage() -> ProgrammingLanguage {
        let langKey = article.type
        let languages = contentStructureProvider.contentStructure.languages
        guard let language = languages[langKey] else {
            fatalError("Programming language '\(langKey)' not found!")
        }
        return language
    }

    private func resolveCurrentAddress() -> TopicAddress {
        let language = resolveProgrammingLanguage()
        let chapter = language.chapters.findViaPath(forCurrent: article)
        let section = chapter?.sections.findViaPath(forCurrent: article)
        let topic = section?.topics.findViaPath(forCurrent: article)

        return TopicAddress(
            programmingLanguage: language,
            chapter: chapter,
            section: section,
            topic: topic
        )
    }

    private func preambleFor(topicAddress: TopicAddress) -> (chapter: Article, section: Article)? {
        guard let chapter = topicAddress.chapter, let section = topicAddress.section else {
            return nil
        }
        guard let chapterArticle = allArticles.all.first(where: { $0.path == chapter.path }) else {
            fatalError("Article for chapter '\(chapter.path)' not found!")
        }
        guard let sectionArticle = allArticles.all.first(where: { $0.path == section.path }) else {
            fatalError("Article for section '\(section.path)' not found!")
        }
        return (chapter: chapterArticle, section: sectionArticle)
    }
}

@MainActor
private extension Array where Element: RoutableNode {
    func findViaPath(forCurrent article: Article) -> Element? {
        first {
            article.path.starts(with: "\($0.path)/") || article.path == $0.path
        }
    }
}
