import Ignite

struct AboutLayout: Layout {

    @Environment(\.site) var site

    var body: Document {
        Head.configured()
        Body {
            // TODO: Programming language selector instead of tabs for convenience
            Header(
                siteName: site.name,
                tabs: nil
            )
            Section {
                Section {
                    Tag("article") {
                        content
                    }

                    homeLink

                    Footer()
                }
                .class("centered-column")
            }
            .id("main")
            .class("about-page")
        }
        .ignorePageGutters()
    }

    @HTMLBuilder
    private var homeLink: some HTML {
        Link("[Go to start page]", target: "/")
            .horizontalAlignment(.center)
    }

}
