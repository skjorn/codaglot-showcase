import Ignite

typealias HeadElementBuilder = ElementBuilder<any HeadElement>

extension Head {
    static func configured() -> Head {
        common()
    }

    static func redirect(to topic: Topic, queryString: String? = nil) -> Head {
        let path = queryString.map { "\(topic.path)?\($0)" } ?? topic.path
        return redirect(to: path)
    }

    static func redirect(to path: String) -> Head {
        common {
            MetaTag(httpEquivalent: "refresh", content: "0;\(rootPath(path))")
        }
    }

    private static func common(@HeadElementBuilder with customHeadElements: () -> [any HeadElement] = {[]}) -> Head {
        @Environment(\.site) var site
        return Head {
            MetaTag(name: "apple-mobile-web-app-title", content: site.name)
            MetaLink(href: "/css/codaglot.css", rel: .stylesheet)
            MetaLink(href: "/css/midnight-run.css", rel: .stylesheet)
            for element in customHeadElements() {
                element
            }

            // Favicon
            MetaLink(href: "/favicon.ico", rel: "shortcut icon")
                .customAttribute(name: "sizes", value: "48x48 32x32 16x16")
            MetaLink(href: "/favicon.svg", rel: .icon)
                .customAttribute(name: "type", value: "image/svg+xml")
            MetaLink(href: "/apple-touch-icon.png", rel: "apple-touch-icon")
                .customAttribute(name: "sizes", value: "180x180")
            MetaLink(href: "/site.webmanifest", rel: .manifest)
        }
    }
}
