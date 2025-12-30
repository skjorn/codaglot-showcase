
typealias HierarchyPath = (chapter: Chapter, section: ContentSection)

extension ProgrammingLanguage {
    var allTopics: [Topic] {
        chapters
            .flatMap(\.sections)
            .flatMap(\.topics)
    }

    var routableNodes: [any RoutableNode] {
        chapters
            .flatMap {
                [$0] + $0.sections.flatMap {
                    [$0] + $0.topics
                }
            }
    }

    func hierarchyFor(topic: Topic?) -> HierarchyPath? {
        guard let topic else {
            return nil
        }

        for chapter in chapters {
            for section in chapter.sections {
                if section.topics.contains(topic) {
                    return (chapter: chapter, section: section)
                }
            }
        }

        return nil
    }
}

extension ContentSection {
    func isFirstTopic(_ topic: Topic) -> Bool {
        topics.first == topic
    }
}
