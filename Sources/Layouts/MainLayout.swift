import Ignite

struct MainLayout: Layout {
    var body: Document {
        Head.configured()
        Body {
            content
            Footer()
        }
    }
}
