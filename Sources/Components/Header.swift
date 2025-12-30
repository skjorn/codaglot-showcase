import Ignite

struct Header: HTML {

    struct TabsConfiguration {
        let programmingLanguage: ProgrammingLanguage
        let currentChapter: String?
    }

    let siteName: String
    let tabs: TabsConfiguration?

    var body: some HTML {
        Tag("header") {
            Section {
                HStack(spacing: .zero) {
                    HStack(spacing: .zero) {
                        Link(target: "/") {
                            Image("/images/logo.svg", description: welcomeMessage)
                        }
                        .id("logo")

                        if let programmingLanguage = tabs?.programmingLanguage.name {
                            Text(programmingLanguage)
                                .class("title")
                        }
                    }
                    Spacer()
                    AboutMenu()
                }

                if let tabs {
                    Tabs(chapters: tabs.programmingLanguage.chapters, currentChapter: tabs.currentChapter)
                }
            }
            .class("centered-column")
        }
    }

    private var welcomeMessage: String {
        "Welcome to the \(siteName) website!"
    }
}
