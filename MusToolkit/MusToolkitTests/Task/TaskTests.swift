//
//  TaskTests.swift
//  MusToolkit
//
//  Created by Joachim Kret on 31/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
@testable import MusToolkit

final class TaskTests: XCTestCase {
    typealias PlainTask = Task<Void, Void>

    func testRunSyncTask() {
        var processed = false
        var finished = false
        let task = PlainTask.sync {
            processed = true
        }

        expect(processed)
            .to(beFalse())
        expect(finished)
            .to(beFalse())

        task.perform(()) {
            finished = true
        }

        expect(processed)
            .to(beTrue())
        expect(finished)
            .to(beTrue())
    }

    func testRunAsyncTask() {
        var processed = false
        var finished = false
        let task = PlainTask.async { (_, completion) in
            processed = true
            completion()
        }

        expect(processed)
            .to(beFalse())
        expect(finished)
            .to(beFalse())

        task.perform(()) {
            finished = true
        }

        expect(processed)
            .to(beTrue())
        expect(finished)
            .to(beTrue())
    }

    func testRunAsyncTaskNotCompleted() {
        var processed = false
        var finished = false
        let task = PlainTask.async { (_, completion) in
            processed = true
        }

        expect(processed)
            .to(beFalse())
        expect(finished)
            .to(beFalse())

        task.perform(()) {
            finished = true
        }

        expect(processed)
            .to(beTrue())
        expect(finished)
            .to(beFalse())
    }

    func testRunTaskComposition() {
        var taskValue1 = false
        let task1 = SyncTask {
            taskValue1 = true
        }

        var taskValue2 = false
        let task2 = SyncTask {
            taskValue2 = true
        }

        let task = Task.apply(task1, task2)

        expect(taskValue1)
            .to(beFalse())
        expect(taskValue2)
            .to(beFalse())

        task.perform()

        expect(taskValue1)
            .to(beTrue())
        expect(taskValue2)
            .to(beTrue())
    }

    func testRunTaskPipelineComposition() {
        var result: String? = nil

        let provider = SyncTask<Void, Int> {
            return 123
        }
        let converter = SyncTask<Int, String> { val in
            return String(val)
        }
        let renderer = SyncTask<String, Void> { val in
            result = val
        }

        let task = Task.apply(Task.apply(provider, converter), renderer)

        expect(result)
            .to(beNil())

        task.perform()

        expect(result)
            .to(equal("123"))
    }

    func testRunTaskCompositionUsingChaining() {
        var taskValue1 = false
        let task1 = SyncTask {
            taskValue1 = true
        }

        var taskValue2 = false
        let task2 = SyncTask {
            taskValue2 = true
        }

        var taskValue3 = false
        let task3 = SyncTask {
            taskValue3 = true
        }

        let task = task1.apply(task2).apply(task3)

        expect(taskValue1)
            .to(beFalse())
        expect(taskValue2)
            .to(beFalse())
        expect(taskValue3)
            .to(beFalse())

        task.perform()

        expect(taskValue1)
            .to(beTrue())
        expect(taskValue2)
            .to(beTrue())
        expect(taskValue3)
            .to(beTrue())
    }

    func testRunTaskCompositionUsingChainingInPipeline() {
        var result: String? = nil

        let provider = SyncTask<Void, Int> {
            return 123
        }
        let converter = SyncTask<Int, String> { val in
            return String(val)
        }
        let renderer = SyncTask<String, Void> { val in
            result = val
        }
        
        let task = provider.apply(converter).apply(renderer)
        
        expect(result)
            .to(beNil())
        
        task.perform()
        
        expect(result)
            .to(equal("123"))
    }
}
