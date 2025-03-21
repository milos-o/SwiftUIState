protocol StateProperty {
    var value: Any { get nonmutating set }
}

@propertyWrapper
struct State<Value>: StateProperty {
    private var box: Box<StateBox<Value>>

    init(wrappedValue: Value) {
        self.box = Box(StateBox(wrappedValue))
    }

    var wrappedValue: Value {
        get { box.value.value }
        nonmutating set { box.value.value = newValue }
    }

    var projectedValue: Binding<Value> {
        box.value.binding
    }

    var value: Any {
        get { box.value }
        nonmutating set { box.value = newValue as! StateBox<Value> }
    }
}

final class Box<Value> {
    var value: Value
    
    init(_ value: Value) {
        self.value = value
    }
}

nonisolated(unsafe) var currentBodies: [Node] = []
nonisolated(unsafe) var currentGlobalBodyNode: Node? { currentBodies.last }

final class StateBox<Value> {
    private var _value: Value
    private var dependencies: [Weak<Node>] = []
    var binding: Binding<Value> = Binding(get: { fatalError() }, set: { _ in fatalError() })

    init(_ value: Value) {
        self._value = value
        self.binding = Binding(
            get: { [unowned self] in
                self.value
            },
            set: { [unowned self] in
                self.value = $0
            }
        )
    }

    var value: Value {
        get {
            if let node = currentGlobalBodyNode {
                dependencies.append(Weak(node))
            }
            // skip duplicates and remove nil entries?
            return _value
        }
        set {
            _value = newValue
            for d in dependencies {
                d.value?.needsRebuild = true
            }
        }
    }
}

final class Weak<A: AnyObject> {
    weak var value: A?
    init(_ value: A) {
        self.value = value
    }
}
