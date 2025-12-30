import Markdown

struct MarkdownPreprocessor: MarkupRewriter {
    mutating func visit(markdown: String) -> String {
        let document = Document(parsing: markdown)
        return visit(document)?.format() ?? ""
    }

    mutating func visitLink(_ link: Link) -> Markup? {
        guard let destination = link.destination else {
            return link
        }

        let isReference = destination.starts(with: "ref:")
        let url = destination.trimmingPrefix("ref:")
        let isAbsolute = url.starts(with: #/https?:/#)
        guard isReference || isAbsolute else {
            return link
        }

        let referenceLabel: String? = if isReference {
            SiteConfiguration.docReferences
                .first { pattern, _ in try! pattern.firstMatch(in: url) != nil }
                .map(\.label)
        } else {
            nil
        }

        let label = referenceLabel ?? link.label ?? String(url)
        let classAttr = isReference ? #"class="reference""# : ""
        return InlineHTML(#"<a target="_blank" \#(classAttr) href="\#(url)">\#(label)</a>"#)
    }

    mutating func visitHeading(_ heading: Heading) -> Markup? {
        switch heading.level {
        case 1: heading1WithAnchor(heading)
        case 2: heading2WithAnchor(heading)
        default: heading
        }
    }

    private func heading1WithAnchor(_ heading: Heading) -> Markup? {
        Heading(level: 1, [
            InlineHTML(#"<a name="start"></a>"#),
            Text(heading.plainText)
        ] as [InlineMarkup])
    }

    private func heading2WithAnchor(_ heading: Heading) -> Markup? {
        var text = heading.plainText.trimmingCharacters(in: .whitespaces)
        let slug: String
        if let match = text.wholeMatch(of: #/<(.+)>\s*(.+)/#) {
            slug = String(match.1)
            text = String(match.2)
        } else {
            slug = String(text.convertedToSlug().prefix(30))
        }
        return Heading(level: 2, [
            InlineHTML(#"<a name="\#(slug)"></a>"#),
            Text(text)
        ] as [InlineMarkup])
    }
}

private extension Link {
    var label: String? {
        let textFromChildren = children
            .map { $0.format() }
            .joined()
            .trimmingCharacters(in: .whitespacesAndNewlines)
        return textFromChildren.isEmpty ? nil : textFromChildren
    }
}
