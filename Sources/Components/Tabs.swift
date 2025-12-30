import Ignite

struct Tabs: HTML {

    let chapters: [Chapter]
    let currentChapter: String?

    var body: some HTML {
        Tag("nav") {
            List(chapters) { chapter in
                Link(chapter.name, target: chapter.path)
                .class(chapter.id == currentChapter ? "selected" : nil)
            }
            .class("list-unstyled", "hstack")
        }
        .id("tabs")
    }
}
