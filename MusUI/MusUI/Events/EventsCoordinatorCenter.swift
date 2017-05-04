//
//  EventsCoordinatorCenter.swift
//  MusUI
//
//  Created by Joachim Kret on 04/05/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

public final class EventsCoordinatorCenter<Input, Output> {
    public let inputs = EventsCoordinator<Input>()
    public let outputs = EventsCoordinator<Output>()
    public init() { }
}
