//
//  AnyBuiltinView.swift
//  SwiftUIState
//
//  Created by Milos on 13.3.25..
//

import Foundation

struct AnyBuiltinView: BuiltinView {
    private var buildNodeTree: (Node) -> ()

    init<V: View>(_ view: V) {
        self.buildNodeTree = view.buildNodeTree(_:)
    }

    func _buildNodeTree(_ node: Node) {
        buildNodeTree(node)
    }
}
