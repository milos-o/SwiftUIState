//
//  Binding.swift
//  SwiftUIState
//
//  Created by Milos on 14.3.25..
//

@propertyWrapper
public struct Binding<Value> {
    var get: () -> Value
    var set: (Value) -> ()

    public var wrappedValue: Value {
        get { get() }
        nonmutating set { set(newValue) }
    }
}
