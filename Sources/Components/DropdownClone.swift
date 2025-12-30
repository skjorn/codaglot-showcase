//
// DropdownItem.swift
// Ignite
// https://www.github.com/twostraws/Ignite
// See LICENSE for license information.
//

import Ignite

// HACK: Copy of Dropdown component from Ignite main:338c29fa7e8f70cd8600248cc4eb60330c1f92ac
// to customize menu alignment

/// Renders a button that presents a menu of information when pressed.
/// Can be used as a free-floating element on your page, or in
/// a `NavigationBar`.
public struct DropdownClone: HTML, NavigationItem, FormItem {
    enum MenuAlignment: Equatable {
        case leading
        case trailing
    }

    /// The content and behavior of this HTML.
    public var body: some HTML { self }

    /// Whether this HTML belongs to the framework.
    public var isPrimitive: Bool { true }

    /// How a `NavigationBar` displays this item at different breakpoints.
    public var navigationBarVisibility: NavigationBarVisibility = .automatic

    /// The title for this `Dropdown`.
    private var title: any InlineElement

    /// The array of items to shown in this `Dropdown`.
    private var items: [any DropdownItem]

    /// How large this dropdown should be drawn. Defaults to `.medium`.
    private var size = Button.Size.medium

    /// How this dropdown should be styled on the screen. Defaults to `.default`.
    private var role = Role.default

    private var classes: Set<String> = []
    private var menuAlignment = MenuAlignment.leading

    /// Creates a new dropdown button using a title and an element that builder
    /// that returns an array of types conforming to `DropdownItem`.
    /// - Parameters:
    ///   - title: The title to show on this dropdown button.
    ///   - items: The elements to place inside the dropdown menu.
    public init(
        _ title: any InlineElement,
        @ElementBuilder<any DropdownItem> items: () -> [any DropdownItem]
    ) {
        self.title = title
        self.items = items()
    }

    /// Creates a new dropdown button using a title and an element that builder
    /// that returns an array of types conforming to `DropdownItem`.
    /// - Parameters:
    ///   - items: The elements to place inside the dropdown menu.
    ///   - title: The title to show on this dropdown button.
    public init(
        @ElementBuilder<any DropdownItem> items: () -> [any DropdownItem],
        @InlineElementBuilder title: () -> any InlineElement
    ) {
        self.items = items()
        self.title = title()
    }

    /// Adjusts the size of this dropdown.
    /// - Parameter size: The new size.
    /// - Returns: A new `Dropdown` instance with the updated size.
    public func dropdownSize(_ size: Button.Size) -> Self {
        var copy = self
        copy.size = size
        return copy
    }

    /// Adjusts the role of this dropdown
    /// - Parameter role: The new role.
    /// - Returns: A new `Dropdown` instance with the updated role.
    public func role(_ role: Role) -> DropdownClone {
        var copy = self
        copy.role = role
        return copy
    }

    func align(_ alignment: MenuAlignment) -> DropdownClone {
        var copy = self
        copy.menuAlignment = alignment
        return copy
    }

    /// Renders this element using publishing context passed in.
    /// - Returns: The HTML for this element.
    public func markup() -> Markup {
        Section(content: renderDropdownContent)
            .class(Array(classes))
            .class("dropdown")
            .markup()
    }

    /// Creates the internal dropdown structure including the trigger button and menu items.
    /// - Returns: A group containing the dropdown's trigger and menu list.
    @HTMLBuilder
    private func renderDropdownContent() -> some BodyElement {
        Button(title)
            .class("btn", "btn-sm")
            .class("dropdown-toggle")
            .data("bs-toggle", "dropdown")
            .aria(.expanded, "false")

        List {
            ForEach(items) { item in
                if let link = item as? Link {
                    ListItem {
                        link.class("dropdown-item")
                            .class("interactive")
                    }
                } else if let text = item as? Text {
                    ListItem {
                        text.class("dropdown-header")
                    }
                }
            }
        }
        .listMarkerStyle(.unordered(.automatic))
        .class("dropdown-menu")
        .class(menuAlignment == .trailing ? "dropdown-menu-end" : nil)
    }

    func classes(_ newClasses: String?...) -> Self {
        var copy = self
        copy.classes = classes.union(newClasses.compactMap { $0 })
        return copy
    }
}
