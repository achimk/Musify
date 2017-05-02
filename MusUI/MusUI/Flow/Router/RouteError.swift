//
//  RouteError.swift
//  MusUI
//
//  Created by Joachim Kret on 23/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

public enum RouteError: Error {
    case notFound(LocationType)
    case invalidArguments(LocationType)
    case invalidPayload(LocationType)
    case unknown(LocationType, Error)
}
