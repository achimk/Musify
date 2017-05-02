//
//  SerialQueue.swift
//  MusToolkit
//
//  Created by Joachim Kret on 31/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

// MARK: SerialQueue

public final class SerialQueue<T: TaskType> {
    private let queue: DispatchQueue
    private(set) var tasks: Array<T>
    private(set) var current: T?

    public init(queue: DispatchQueue = .main, tasks: Array<T> = []) {
        self.queue = queue
        self.tasks = tasks
    }

    public func append(_ task: T) {
        tasks.append(task)
    }

    public func append<S: Sequence>(contentsOf: S) where S.Iterator.Element == T {
        tasks.append(contentsOf: contentsOf)
    }

    public func append<C: Collection>(contentsOf: C) where C.Iterator.Element == T {
        tasks.append(contentsOf: contentsOf)
    }

    public func run(_ input: T.I, _ completion: ((T.O) -> Void)? = nil) {
        let queue = self.queue

        let dispatch: ((@escaping ((Void) -> Void)) -> Void) = { (callback) in
            if DispatchQueue.main === queue && Thread.isMainThread{
                callback()
            } else {
                queue.async {
                    callback()
                }
            }
        }

        let dequeue: ((Void) -> Void) = { [weak self] in
            self?.tasks.removeFirst()
            self?.current = nil
            self?.run(input, completion)
        }

        let result: ((T.O) -> Void) = { output in
            dispatch {
                completion?(output)
                dequeue()
            }
        }

        dispatch { [weak self] in
            guard self?.current == nil else { return }
            guard let task = self?.tasks.first else { return }
            self?.current = task
            task.perform(input, completion: result)
        }
    }
}

extension SerialQueue where T.I == Void {
    public final func run(_ completion: ((T.O) -> Void)? = nil) {
        run((), completion)
    }
}
