//
//  Task.swift
//  MusToolkit
//
//  Created by Joachim Kret on 31/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

// MARK: TaskType

public protocol TaskType {
    associatedtype I
    associatedtype O
    func perform(_ input: I, completion: @escaping ((O) -> Void))
}

extension TaskType {
    public final func perform(_ input: I) {
        perform(input, completion: { _ in })
    }
}

extension TaskType where I == Void {
    public final func perform() {
        perform((), completion: { _ in })
    }

    public final func perform(completion: @escaping ((O) -> Void)) {
        perform((), completion: completion)
    }
}

// MARK: Task

public class Task<Input, Output>: TaskType {
    public typealias I = Input
    public typealias O = Output

    public init() { }

    public func perform(_ input: Input, completion: @escaping ((O) -> Void)) {
        fatalError("\(type(of: self)): \(#function) Can't use abstract class directly!")
    }
}

extension Task {
    public func asTask() ->Task<Input, Output> {
        return self
    }
}

extension Task {
    public static func sync(_ operation: @escaping SyncOperation<I, O>) -> Task<I, O> {
        return SyncTask(operation: operation).asTask()
    }
}

extension Task {
    public static func async(_ operation: @escaping AsyncOperation<I, O>) -> Task<I, O> {
        return AsyncTask(operation: operation).asTask()
    }
}

extension Task {
    public func apply<T>(_ task: Task<O, T>) -> Task<I, T> {
        return Task.apply(self, task)
    }

    public static func apply<T>(_ lhs: Task<I, O>, _ rhs: Task<O, T>) -> Task<I, T> {
        return AsyncTask<I, T> { (input, completion) in
            lhs.perform(input) { (output) in
                rhs.perform(output) { (result) in
                    completion(result)
                }
            }
        }
    }
}

// MARK: Sync Task

public typealias SyncOperation<I, O> = ((I) -> O)

public final class SyncTask<Input, Output>: Task<Input, Output> {
    private let operation: SyncOperation<Input, Output>

    public init(operation: @escaping SyncOperation<Input, Output>) {
        self.operation = operation
        super.init()
    }

    public override func perform(_ input: Input, completion: @escaping ((Output) -> Void)) {
        completion(operation(input))
    }
}

// MARK: Async Task

public typealias AsyncOperation<I, O> = (I, @escaping (O) -> Void) -> Void

public final class AsyncTask<Input, Output>: Task<Input, Output> {
    private let operation: AsyncOperation<Input, Output>

    public init(operation: @escaping AsyncOperation<Input, Output>) {
        self.operation = operation
        super.init()
    }

    public override func perform(_ input: Input, completion: @escaping ((Output) -> Void)) {
        operation(input, completion)
    }
}
