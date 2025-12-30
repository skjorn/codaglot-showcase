import Foundation
import Ignite

struct ErrorPage: Ignite.ErrorPage {
    let title = "Not found"

    let description = "Page doesn't exist"

    var layout: ErrorLayout {
        ErrorLayout()
    }

    var body: some HTML {
        EmptyHTML()
    }
}
