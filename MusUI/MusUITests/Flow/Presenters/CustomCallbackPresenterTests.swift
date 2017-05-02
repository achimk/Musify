//
//  CustomCallbackPresenterTests.swift
//  MusUI
//
//  Created by Joachim Kret on 22/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
@testable import MusUI

final class CustomCallbackPresenterTests: XCTestCase {

    func testPresentController() {
        var isVisible = false
        let viewController = UIViewController()
        let presenter = CustomCallbackPresenter { _ in
            isVisible = true
        }

        expect(isVisible)
            .to(beFalse())

        presenter.present(viewController: viewController)

        expect(isVisible)
            .to(beTrue())
    }
}

