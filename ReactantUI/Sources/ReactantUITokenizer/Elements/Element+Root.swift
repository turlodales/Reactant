import Foundation
import SWXMLHash

extension Element {
    public struct Root: XMLIndexerDeserializable, UIContainer, StyleContainer {
        public let type: String
        public let isRootView: Bool
        public let styles: [Style]
        public let stylesName: String
        public let children: [UIElement]
        public let edgesForExtendedLayout: [RectEdge]
        public let isAnonymous: Bool

        public var componentTypes: [String] {
            return [type] + Root.componentTypes(in: children)
        }

        private static func componentTypes(in elements: [UIElement]) -> [String] {
            return elements.flatMap { element -> [String] in
                switch element {
                case let ref as ComponentReference:
                    return [ref.type]
                case let tableView as PlainTableView:
                    return [tableView.cellType]
                case let container as UIContainer:
                    return componentTypes(in: container.children)
                default:
                    return []
                }
            }
        }

        public static func deserialize(_ node: XMLIndexer) throws -> Root {
            return try Root(
                type: node.value(ofAttribute: "type"),
                isRootView: node.value(ofAttribute: "rootView") ?? false,
                styles: node["styles"].children.flatMap { try? $0.value() },
                stylesName: node["styles"].element?.attribute(by: "name")?.text ?? "Styles",
                children: View.deserialize(nodes: node.children),
                edgesForExtendedLayout: (node.element?.attribute(by: "extend")?.text).map(RectEdge.parse) ?? [],
                isAnonymous: node.value(ofAttribute: "anonymous") ?? false)
        }
    }
}