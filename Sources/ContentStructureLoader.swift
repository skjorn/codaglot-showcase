import Ignite

@MainActor
protocol ContentStructureProvider {
    var contentStructure: ContentStructure { get }
}

@MainActor
class ContentStructureLoader: ContentStructureProvider {

    private var loadedContentStructure: ContentStructure?

    var contentStructure: ContentStructure {
        guard let loadedContentStructure else {
            fatalError("Content structure requested before being loaded")
        }

        return loadedContentStructure
    }

    func load(articleLoader: ArticleLoader) {
        let articles = articleLoader
        let languageKeys = Set(articles.all.map(\.type))
        loadedContentStructure = ContentStructure(
            languages: Dictionary(
                uniqueKeysWithValues: languageKeys.map { langKey in
                    (langKey, loadProgrammingLanguage(withKey: langKey, from: articles))
                }
            )
        )
    }

    private func loadProgrammingLanguage(withKey key: String, from articles: ArticleLoader) -> ProgrammingLanguage {
        let path = "/\(key)"
        guard let category = articles.all.resolveCategoryArticle(for: path) else {
            fatalError("index.md for programming language path '\(path)' not found!")
        }
        return ProgrammingLanguage(
            id: key,
            name: category.title,
            chapters: loadChapters(from: articles.typed(key))
                .sortedBy(articleMetadata: category)
        )
    }

    private func loadChapters(from articles: [Article]) -> [Chapter] {
        let categorizedArticles = articles.map { ArticleWithTokenizedPath(article: $0, path: $0.path) }
        let expectedChapters = Set(categorizedArticles.compactMap(\.pathTokens.chapterKey))
        let chapters: [Chapter] = categorizedArticles
            .compactMap {
                guard let chapterKey = $0.pathTokens.chapterKey, $0.pathTokens.sectionKey == nil else {
                    return nil
                }
                return Chapter(
                    id: chapterKey,
                    name: $0.article.title,
                    path: $0.article.path,
                    sections: loadSections(from: categorizedArticles.filter { $0.pathTokens.chapterKey == chapterKey })
                        .sortedBy(articleMetadata: $0.article)
                )
            }

        let loadedChapters = Set(chapters.map(\.id))
        guard loadedChapters == expectedChapters else {
            fatalError("Missing index.md for expected chapters: \(expectedChapters.subtracting(loadedChapters))")
        }

        return chapters
    }

    private func loadSections(from articles: [ArticleWithTokenizedPath]) -> [ContentSection] {
        let expectedSections = Set(articles.compactMap(\.pathTokens.sectionKey))
        let sections: [ContentSection] = articles
            .compactMap {
                guard let sectionKey = $0.pathTokens.sectionKey, $0.pathTokens.topicKey == nil else {
                    return nil
                }
                return ContentSection(
                    id: sectionKey,
                    name: $0.article.title,
                    path: $0.article.path,
                    topics: loadTopics(from: articles.filter { $0.pathTokens.sectionKey == sectionKey })
                        .sortedBy(articleMetadata: $0.article)
                )
            }

        let loadedSections = Set(sections.map(\.id))
        guard loadedSections == expectedSections else {
            fatalError("Missing index.md for expected sections: \(expectedSections.subtracting(loadedSections))")
        }

        return sections
    }

    private func loadTopics(from articles: [ArticleWithTokenizedPath]) -> [Topic] {
        articles
            .compactMap {
                guard let topicKey = $0.pathTokens.topicKey else {
                    return nil
                }
                return Topic(
                    id: topicKey,
                    name: $0.article.title,
                    path: $0.article.path,
                    subTopics: loadSubTopics(from: $0.article)
                )
            }
    }

    private func loadSubTopics(from article: Article) -> [SubTopic] {
        HTMLAnalyzer(article: article).headings()
            .filter { $0.level == 2 }
            .map {
                assert($0.anchorName != nil, "Anchor should have been automatically populated by the preprocessing step!")
                return SubTopic(id: $0.anchorName!, name: $0.text)
            }
    }
}

private struct ArticleWithTokenizedPath {
    let article: Article
    let pathTokens: TokenizedPath

    init(article: Article, path: String) {
        self.article = article
        self.pathTokens = TokenizedPath(fromPath: path)
    }
}

private struct TokenizedPath {
    let programmingLanguageKey: String
    let chapterKey: String?
    let sectionKey: String?
    let topicKey: String?

    init(fromPath path: String) {
        let tokens = path.split(separator: "/", omittingEmptySubsequences: true).map(String.init)
        guard tokens.count > 0 else {
            fatalError("Path '\(path)' should contain at least a programming language")
        }
        guard tokens.count < 5 else {
            fatalError("Path '\(path)' has too many components! 4 levels of nesting are supported: Programming language > Chapter > Section > Topic")
        }

        let paddedTokens = if tokens.count == 4 {
            tokens
        } else {
            tokens + Array(repeating: nil, count: 4 - tokens.count)
        }
        programmingLanguageKey = tokens[0]
        chapterKey = paddedTokens[1]
        sectionKey = paddedTokens[2]
        topicKey = paddedTokens[3]
    }
}

@MainActor
private extension Array where Element == Article {
    func resolveCategoryArticle(for path: String) -> Article? {
        first { $0.path == path }
    }
}

@MainActor
private extension Array where Element: Identifiable, Element.ID == String {
    func sortedBy(articleMetadata: Article) -> [Element] {
        sorted { el in
            let order = articleMetadata.contentOrder
            guard let index = order.firstIndex(of: el.id) else {
                fatalError("I don't know how to sort article '\(el.id)'. Check sorting order at '\(articleMetadata.path)'")
            }
            return index
        }
    }
}

private extension Article {
    var contentOrder: [String] {
        guard let values = metadata["content_order"] as? String else {
            fatalError("Failed to retrieve sorting order from article at '\(path)'")
        }
        return values
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespaces) }
    }
}
