import Foundation
import Ignite

@main
struct IgniteWebsite {
    static func main() async {
        var site = CodaglotSite()

        do {
            try await site.publish()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct CodaglotSite: Site {
    let name = "Codaglot"
    let titleSuffix = " | Codaglot"
    let url = URL(static: "https://codaglot.skjorn.name")
    let builtInIconsEnabled = BootstrapOptions.none
    // Favicon handled via custom code in head element

    let author = "Šimon Kručinin"

    let homePage = HomePage()
    let errorPage = ErrorPage()
    let layout = MainLayout()
    var staticPages: [any StaticPage] {
        AboutPage()
        PrivacyPolicyPage()
        SourcesPage()
    }
    var articlePages: [any ArticlePage] {
        TopicPage(contentStructureProvider: contentStructureLoader)
    }

    var articleRenderer: EnrichedArticleRenderer.Type {
        EnrichedArticleRenderer.self
    }

    var darkTheme: (any Theme)? { CodaglotDarkTheme() }
    var lightTheme: (any Theme)? { CodaglotDarkTheme() }

    var syntaxHighlighterConfiguration: SyntaxHighlighterConfiguration {
        .init(languages: [.kotlin], shouldWrapLines: true)
    }

    private let contentStructureLoader = ContentStructureLoader()

    mutating func prepare() async throws {
        @Environment(\.articles) var articles
        contentStructureLoader.load(articleLoader: articles)
    }
}
