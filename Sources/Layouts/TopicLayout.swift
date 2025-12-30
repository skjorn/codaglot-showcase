import Ignite

struct TopicLayout: Layout {

    @Environment(\.site) var site
    let topicAddress: TopicAddress
    let preamble: (chapter: Article, section: Article)?
    
    var body: Document {
        head
        Body {
            Section {
                Header(
                    siteName: site.name,
                    tabs: .init(
                        programmingLanguage: topicAddress.programmingLanguage,
                        currentChapter: topicAddress.chapter?.id
                    )
                )
                Section {
                    Section {
                        if let chapter = topicAddress.chapter, let section = topicAddress.section, let topic = topicAddress.topic {
                            articleView(
                                programmingLanguage: topicAddress.programmingLanguage,
                                chapter: chapter,
                                section: section,
                                topic: topic
                            )
                        }
                    }
                    .class("centered-column")
                }
                .id("main")
            }
            .id("panned-content")

            if let chapter = topicAddress.chapter {
                SideMenu(formFactor: .mobile, chapter: chapter, selectedTopic: topicAddress.topic)
            }
            Script(file: "/js/codaglot.js")
        }
        .ignorePageGutters()
    }

    private var head: Head {
        if topicAddress.topic != nil {
            Head.configured()
        } else {
            Head.redirect(to: topicAddress.resolvedTopic, queryString: "expand=1")
        }
    }

    @HTMLBuilder
    private func articleView(
        programmingLanguage: ProgrammingLanguage,
        chapter: Chapter,
        section: ContentSection,
        topic: Topic
    ) -> some HTML {
        SideMenu(formFactor: .desktop, chapter: chapter, selectedTopic: topic)

        Tag("article") {
            if let preamble {
                TopicPreamble(
                    chapter: preamble.chapter,
                    section: preamble.section,
                    programmingLanguage: programmingLanguage,
                    expand: section.isFirstTopic(topic)
                )
            }
            PhoneNavButton()
            content
        }
        PhoneNavButton()
        Paging(contentStructure: programmingLanguage, currentTopic: topic)
        
        Footer()
    }
}
