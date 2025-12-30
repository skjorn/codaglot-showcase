import Ignite

struct HomeLayout: Layout {
    var body: Document {
        // TODO: Temporary until other languages are introduced. Then replace the redirect with a fun language selector.
        Head.redirect(to: "/kotlin")
        Body {
            content
        }
    }
}
