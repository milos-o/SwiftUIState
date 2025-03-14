import Foundation

final class Node {
    var children: [Node] = []
    var needsRebuild = true
    var view: BuiltinView!

    func rebuildIfNeeded() {
        view._buildNodeTree(self)
    }
}
