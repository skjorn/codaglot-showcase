import Ignite

struct PrivacyPolicyPage: StaticPage {
    let path = "/privacy-policy"
    let title = "Privacy and Cookie Policy"

    var layout: AboutLayout {
        AboutLayout()
    }

    @HTMLBuilder
    var body: some HTML {
        Text(title)
            .font(.title1)

        Text("This site doesn’t collect any personal data.")

        Text {
            "This site tracks user visits through the "
            Link("PostHog", target: "https://posthog.com")
                .target(.newWindow)
            " analytics platform, which collects basic, personally non-identifiable information such as time of the visit, device and system platform of the user, origin country of the network request, and similar."
        }

        Text("Stored information (colloquially Cookies)")
            .font(.title2)

        Text("There’s no information stored on the user’s device by this site directly or through third-party libraries.")
    }
}
