import Foundation

final class Node {
    var children: [Node] = []
    var needsRebuild = true
    var view: BuiltinView!
    var previousView: Any?
    var stateProperties: [String: Any] = [:]

    func rebuildIfNeeded() {
        view._buildNodeTree(self)
    }
}
