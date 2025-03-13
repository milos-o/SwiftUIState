import Foundation

final class Node {
    var children: [Node] = []
    var needsRebuild = true
    var view: BuiltinView!

    func rebuildIfNeeded() {
        if needsRebuild {
            view._buildNodeTree(self)
        }
    }
}
