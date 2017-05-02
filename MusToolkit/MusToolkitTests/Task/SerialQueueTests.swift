//
//  SerialQueueTests.swift
//  MusToolkit
//
//  Created by Joachim Kret on 31/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
@testable import MusToolkit

final class SerialQueueTests: XCTestCase {
    typealias PlainTask = Task<Void, Void>

    func testCreateQueue() {
        let queue = SerialQueue<PlainTask>()

        expect(queue)
            .toNot(beNil())
    }

    func testRunTask() {
        var processed = false
        let queue = SerialQueue<PlainTask>()
        let task = PlainTask.sync {
            processed = true
        }

        queue.append(task)

        expect(processed)
            .to(beFalse())

        queue.run()

        expect(processed)
            .to(beTrue())
    }

    func testRunMultipleTasks() {
        var items = Array<Bool>()
        var tasks: Array<PlainTask> = []
        for _ in 0 ..< 10 {
            let task = PlainTask.sync {
                items.append(true)
            }
            tasks.append(task)
        }

        let queue = SerialQueue<PlainTask>()
        queue.append(contentsOf: tasks)

        expect(items.count)
            .to(equal(0))

        queue.run()

        expect(items.count)
            .to(equal(10))
    }

    func testRunMultipleTasksAndCompletion() {
        var items = Array<Bool>()
        var tasks: Array<PlainTask> = []
        for _ in 0 ..< 10 {
            let task = PlainTask.sync {
                items.append(true)
            }
            tasks.append(task)
        }

        let queue = SerialQueue<PlainTask>()
        queue.append(contentsOf: tasks)

        expect(items.count)
            .to(equal(0))

        var index: Int = 0
        queue.run {
            index = index.advanced(by: 1)
            expect(items.count)
                .to(equal(index))
        }
        
        expect(items.count)
            .to(equal(10))
    }
}
