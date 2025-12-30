
extension TopicAddress {
    var resolvedTopic: Topic {
        topic ?? (
            section ?? (
                chapter ?? programmingLanguage.chapters.first!
            ).sections.first!
        ).topics.first!
    }
}
