import Ignite

struct Paging: HTML {

    let contentStructure: ProgrammingLanguage
    let currentTopic: Topic

    var body: some HTML {
        let previousTopic = currentTopic.previous(in: contentStructure)
        let nextTopic = currentTopic.next(in: contentStructure)
        HStack(spacing: .zero) {
            if let prev = previousTopic {
                Link("[--]", target: prev.path)
                    .relationship(.prev)
                    .attribute("title", "Previous")
            }
            if let next = nextTopic {
                Link("[++]", target: next.path)
                    .relationship(.next)
                    .attribute("title", "Next")
            }
        }
        .id("paging")
        .class(pagingClassForCombination(previous: previousTopic, next: nextTopic))
    }

    private func pagingClassForCombination(previous: Topic?, next: Topic?) -> String? {
        switch (previous, next) {
        case (.some, .some): "mid-article"
        case (.some, .none): "last-article"
        case (.none, .some): "first-article"
        case (.none, .none): nil
        }
    }
}

private extension Topic {
    func previous(in structure: ProgrammingLanguage) -> Topic? {
        let topics = structure.allTopics
        guard let index = topics.firstIndex(of: self), index > 0 else {
            return nil
        }
        return topics[index - 1]
    }

    func next(in structure: ProgrammingLanguage) -> Topic? {
        let topics = structure.allTopics
        guard let index = topics.firstIndex(of: self), index < topics.endIndex - 1 else {
            return nil
        }
        return topics[index + 1]
    }
}
