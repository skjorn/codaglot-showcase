import Ignite

struct Footer: HTML {

    var body: some HTML {
        Tag("footer") {
            Span("Copyright © 2025-26 Šimon Kručinin")

            Span {
                Link("CC-BY-4.0", target: "https://creativecommons.org/licenses/by/4.0/")
                    .target(.newWindow)
            }

            Span {
                Link("Privacy & Cookie Policy", target: PrivacyPolicyPage())
            }

            Span {
                "Made with "
                Link("Ignite", target: "https://github.com/twostraws/Ignite")
                .target(.newWindow)
            }
        }
        .class("hstack")
    }
}
