import Ignite

struct CodaglotDarkTheme: Theme {
    // MARK: Colors

    let colorScheme: ColorScheme = .dark
    // TODO: Not supported yet. Need to override via injecting CSS in the head.
//    let syntaxHighlighterTheme: HighlighterTheme = .custom(name: "Midnight Run", filePath: "css/midnight-run.css")

    let background = SemanticColor.pageBackground
    let secondaryBackground = SemanticColor.headerBackground

    let primary = SemanticColor.text
    let secondary = SemanticColor.footer
    let link = SemanticColor.interactive
    let hoveredLink = SemanticColor.interactive
    let linkDecoration: TextDecoration = .none
    let border = SemanticColor.menuBorder

    // MARK: Fonts

    // Note: The root font size is left intentionally unspecified. It should be decided by the browser.
    // Spacings and other font sizes are relative to that. The design reference is 1rem = 16px.

    let codeBlockFontSize: LengthUnit = .rem(0.875)

    let headingFontWeight: FontWeight = .medium

    // MARK: Dimensions

    let siteWidth = ResponsiveValues(.px(800))

    let breakpoints = ResponsiveValues(
        .px(0),
        small: .px(410),  // Roughly Plus and Max models of iPhone, no side nav fold, bigger side padding
        medium: .px(788), // Tablets, with side nav fold
        large: .px(1280)  // Desktop, side nav visible
    )

    let h1Size = ResponsiveValues(.rem(1.43))
    let h2Size = ResponsiveValues(.rem(1.14))

    let paragraphBottomMargin: LengthUnit = .rem(0.5)
}
