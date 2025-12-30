protocol RoutableNode: Identifiable {
    var name: String { get }
    var path: String { get }
}

struct ContentStructure {
    let languages: Dictionary<String, ProgrammingLanguage>
}

struct ProgrammingLanguage: RoutableNode, Equatable {
    let id: String
    let name: String
    var chapters: [Chapter]

    var path: String {
        "/\(id)"
    }

    static func ==(left: ProgrammingLanguage, right: ProgrammingLanguage) -> Bool {
        left.id == right.id
    }
}

struct Chapter: RoutableNode, Equatable {
    let id: String
    let name: String
    let path: String
    var sections: [ContentSection]

    static func ==(left: Chapter, right: Chapter) -> Bool {
        left.path == right.path
    }
}

struct ContentSection: RoutableNode, Equatable {
    let id: String
    let name: String
    let path: String
    var topics: [Topic]

    static func ==(left: ContentSection, right: ContentSection) -> Bool {
        left.path == right.path
    }
}

struct Topic: RoutableNode, Equatable {
    let id: String
    let name: String
    let path: String
    var subTopics: [SubTopic]

    static func ==(left: Topic, right: Topic) -> Bool {
        left.path == right.path
    }
}

struct SubTopic: Equatable {
    let id: String
    let name: String
}
