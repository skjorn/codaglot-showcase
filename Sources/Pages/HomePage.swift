import Foundation
import Ignite

struct HomePage: StaticPage {
    var title = "Home"

    var layout: HomeLayout {
        HomeLayout()
    }

    var body: some HTML {
        EmptyHTML()
    }
}
