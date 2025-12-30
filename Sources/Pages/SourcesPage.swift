import Ignite

struct SourcesPage: StaticPage {
    let path = "/sources"
    let title = "Sources"

    var layout: AboutLayout {
        AboutLayout()
    }

    @HTMLBuilder
    var body: some HTML {
        Text(title)
            .font(.title1)

        Text("The material on this site is based on the following sources.")

        Text("Kotlin")
            .font(.title2)

        List {
            ListItem {
                VStack(alignment: .leading) {
                    Text("Official language documentation (version 2.0 used as reference):")
                    Link("https://kotlinlang.org/docs/basic-types.html", target: "https://kotlinlang.org/docs/basic-types.html")
                        .target(.newWindow)
                }
            }
            ListItem {
                VStack(alignment: .leading) {
                    Text(markdown: "Book _Kotlin in Action_ by Roman Elizarov, Svetlana Isakova, Sebastian Aigner, Dmitry Jemerov")
                    Text("ISBN-13 978-1-61729-960-5")
                        .fontWeight(.thin)
                    Link(target: "https://amzn.eu/d/39rU6nC") {
                        Image("/images/kotlin-in-action.jpg", description: "Book cover with a link to Amazon store")
                            .resizable()
                            .class("source-illustration")
                    }
                        .target(.newWindow)
                }
            }
        }
    }
}
