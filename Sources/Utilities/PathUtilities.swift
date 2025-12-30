import Foundation

func rootPath(_ path: String) -> String {
    path.starts(with: "/") ? path : "/" + path
}
