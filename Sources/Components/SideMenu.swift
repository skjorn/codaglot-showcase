import Ignite

struct SideMenu: HTML {

    enum FormFactor {
        case desktop
        case mobile
    }

    let formFactor: FormFactor
    let chapter: Chapter
    let selectedTopic: Topic?

    var body: some HTML {
        Tag("nav") {
            List {
                ForEach(chapter.sections) { section in
                    ListItem {
                        Span {
                            section.name
                        }
                        .class("section-item")
                        
                        List {
                            ForEach(section.topics) { topic in
                                ListItem {
                                    if let selectedTopic, topic == selectedTopic {
                                        Link(topic.name, target: withExpandQuery("#start"))
                                        List(topic.subTopics) { subTopic in
                                            Link(subTopic.name, target: withExpandQuery("#\(subTopic.id)"))
                                        }
                                        .class("subtopics-nav")
                                    } else {
                                        Link(topic.name, target: withExpandQuery(topic.path))
                                    }
                                }
                                .class(topic == selectedTopic ? "selected-topic" : nil)
                            }
                        }
                    }
                    .class(section.hasTopic(selectedTopic) ? "selected-section" : nil)
                }
            }

            if formFactor == .mobile {
                toggleButton
            }
        }
        .id(formFactor.id)
    }

    private var toggleButton: some HTML {
        Section {
            Button(Svg(fromFile: "menu-chevron.svg"))
                .role(.none)
        }
        .class("side-nav-toggle")
    }

    private func withExpandQuery(_ url: String) -> String {
        if formFactor == .mobile {
            "\(url)?expand=1"
        } else {
            url
        }
    }
}

private extension SideMenu.FormFactor {
    var id: String {
        switch self {
        case .desktop: "chapter-nav"
        case .mobile: "chapter-nav-phone"
        }
    }
}

private extension ContentSection {
    func hasTopic(_ topic: Topic?) -> Bool {
        guard let topic else {
            return false
        }
        return topics.contains(topic)
    }
}
