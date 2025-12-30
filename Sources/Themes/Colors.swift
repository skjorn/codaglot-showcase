import Ignite

enum Palette {
    static let green300 = Color(hex: "#00A362")
    static let green700 = Color(hex: "#001508")

    static let blue700 = Color(hex: "#0A1631")

    static let white = Color(hex: "#EBEBEB")
    static let grey200 = Color(hex: "#C3C3C3")
    static let grey400 = Color(hex: "#777777")

    static let greyBlue650 = Color(hex: "#1E2629")

    static let orange100 = Color(hex: "#FDEDEA")
    static let orange200 = Color(hex: "#F8C1B4")
    static let orange300 = Color(hex: "#F48A66")

    static let pink200 = Color(hex: "#FDA9C1")
    static let pink500 = Color(hex: "#A20B54")
    static let pink650 = Color(hex: "#53072E")
    static let pink680 = Color(hex: "#380C25")
}

enum SemanticColor {
    static let pageBackground = Palette.blue700
    static let headerBackground = Palette.green700

    static let text = Palette.white
    static let interactive = Palette.orange300
    static let interactiveSubtle = Palette.orange200
    static let footer = Palette.grey200
    static let heading = Palette.green300
    static let topicTitle = Palette.pink500
    static let inlineCode = Palette.green300
    static let externalLinkURL = Palette.grey400
    static let localLink = Palette.pink200

    static let menuBorder = Palette.pink650
    static let menuSectionBackground = Palette.greyBlue650
    static let menuSelectedSectionBackground = Palette.pink680
    static let menuSelectedItem = Palette.pink500
    static let menuHover = Palette.pink500

    // Highlighter theme Midnight Run
    static let codeBackground = Palette.green700.opacity(0.5)
    static let codeComment = Palette.grey400
    static let codeKeyword = Palette.green300
    static let codeLiteral = Palette.orange200
}
