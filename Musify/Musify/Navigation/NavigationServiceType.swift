//
//  NavigationServiceType.swift
//  Musify
//
//  Created by Joachim Kret on 29/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusUI

protocol NavigationServiceType {
    func open(_ url: URL, presenter: ViewControllerPresentable)
    func open(_ location: LocationType, presenter: ViewControllerPresentable)
}
