//
//  FlowPresentable.swift
//  MusUI
//
//  Created by Joachim Kret on 22/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

public protocol FlowPresentable {
    func present(using presenter: ViewControllerPresentable)
}
