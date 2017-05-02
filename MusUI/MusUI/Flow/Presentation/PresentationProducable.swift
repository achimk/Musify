//
//  PresentationProducable.swift
//  MusUI
//
//  Created by Joachim Kret on 22/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

public protocol PresentationProducable {
    func createWindowPresenter() -> ViewControllerPresentable
    func createNavigationPresenter(animated: Bool) -> ViewControllerPresentable
}
