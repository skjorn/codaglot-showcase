import Ignite

struct PhoneNavButton: HTML {

    var body: some HTML {
        Section {
            Button(Svg(fromFile: "menu-chevron.svg"))
                .role(.none)
        }
        .class("side-nav-toggle-inline")
    }
}
