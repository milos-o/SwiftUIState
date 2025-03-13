import XCTest
@testable import SwiftUIState
import Combine

final class Model: ObservableObject {
    @Published var counter: Int = 0
}

struct ContentView: View {
    var model = Model()

    var body: some View {
        Button("\(model.counter)") {
            model.counter += 1
        }
    }
}

final class SwiftUIStateTests: XCTestCase {
    func testExample() {
        let v = ContentView()
        let node = Node()
        v.buildNodeTree(node)
        var button: Button {
            node.children[0].view as! Button
        }
        XCTAssertEqual(button.title, "0")
        button.action()
        node.needsRebuild = true // TODO this should happen automatically
        node.rebuildIfNeeded()
        XCTAssertEqual(button.title, "1")
    }
}
