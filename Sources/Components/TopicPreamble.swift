import Ignite

struct TopicPreamble: HTML {
    let chapter: Article
    let section: Article
    let programmingLanguage: ProgrammingLanguage
    let expand: Bool

    var body: some HTML {
        Accordion {
            Item(itemLabel, startsOpen: expand) {
                Section {
                    Text(chapter.postprocessedText(in: programmingLanguage, stripToParagraphs: true))
                }
                .class("preamble-chapter")
                Text(section.title)
                .class("preamble-section-title")
                Section {
                    Text(section.postprocessedText(in: programmingLanguage, stripToParagraphs: true))
                }
                .class("preamble-section")
            }
        }
    }

    private var itemLabel: some InlineElement {
        Span(section.title)
        .class("preamble-title")
    }
}
