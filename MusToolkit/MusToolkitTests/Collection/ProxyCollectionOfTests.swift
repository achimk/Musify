//
//  ProxyCollectionOfTests.swift
//  MusToolkit
//
//  Created by Joachim Kret on 18/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
@testable import MusToolkit

// MARK: ProxyCollectionOfTests

final class ProxyCollectionOfTests: XCTestCase {

    // MARK: Tests

    func testCreateEmpty() {
        let contents: Array<Int> = []
        let proxy = ProxyCollectionOf(collection: contents).asCollection()
        XCTAssertNotNil(proxy)
        XCTAssertEqual(proxy.count, 0)
    }

    func testCreateWithContent() {
        let contents: Array<Int> = [0, 1, 2, 3, 4, 5]
        let proxy = ProxyCollectionOf(collection: contents).asCollection()
        XCTAssertNotNil(proxy)
        XCTAssertEqual(proxy.count, 6)
    }
}
