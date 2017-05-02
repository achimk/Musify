//
//  CollectionOfTests.swift
//  MusToolkit
//
//  Created by Joachim Kret on 18/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
@testable import MusToolkit

// MARK: CollectionOfTests

final class CollectionOfTests: XCTestCase {

    // MARK: Tests

    func testCreateUsingEmptyCollection() {
        let contents: Array<String> = []
        let collection = CollectionOf.using(contents)
        XCTAssertNotNil(collection)
        XCTAssertEqual(collection.count, 0)
    }

    func testCreateUsingCollection() {
        let contents: Array<String> = ["0", "1", "2", "3", "4", "5"]
        let collection = CollectionOf.using(contents)
        XCTAssertNotNil(collection)
        XCTAssertEqual(collection.count, 6)
    }

    func testCreateUsingCollectionAndMap() {
        let contents: Array<String> = ["0", "1", "2", "3", "4", "5"]
        let collection = CollectionOf.using(contents).map { (item) -> Int in
            return Int(item) ?? 0
        }

        XCTAssertNotNil(collection)
        XCTAssertEqual(collection.count, 6)

        for (index, item) in collection.enumerated() {
            XCTAssertEqual(index, item)
        }
    }
}

