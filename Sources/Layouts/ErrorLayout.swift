import Ignite

struct ErrorLayout: Layout {
    var body: Document {
        Head.redirect(to: "/")
        Body {
            content
        }
    }
}
