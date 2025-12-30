import Ignite

@MainActor
private let aboutPages: [any StaticPage] = [AboutPage(), SourcesPage()]

struct AboutMenu: HTML {

    var body: some HTML {
        DropdownClone {
            for page in aboutPages {
                Link(page.title, target: page)
            }
        } title: {
            Svg(fromFile: "about-menu.svg")
        }
            .dropdownSize(.small)
            .align(.trailing)
            .classes("interactive")
    }
}
