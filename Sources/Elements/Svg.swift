import Ignite

// TODO: Generate SVG tag as a convenience: width, height, view port, preserveAspectRatio, role="img"
struct Svg: InlineElement {
    enum Content {
        case file(fileName: String)
        case text(String)
    }

    let content: Content

    init(fromFile fileName: String) {
        self.content = .file(fileName: fileName)
    }

    init(content: () -> String) {
        self.content = .text(content())
    }

    var body: some InlineElement { self }

    func markup() -> Markup {
        switch content {
        case .file(let fileName):
            Include(fileName).markup()
        case .text(let string):
            string.markup()
        }
    }
}
