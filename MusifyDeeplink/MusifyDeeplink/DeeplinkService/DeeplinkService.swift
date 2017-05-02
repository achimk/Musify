//
//  DeeplinkService.swift
//  MusifyDeeplink
//
//  Created by Joachim Kret on 08/04/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift

protocol DeeplinkServiceType {
    func deeplinks() -> Observable<Array<DeeplinkType>>
}

struct DeeplinkService: DeeplinkServiceType {
    private let results: Array<DeeplinkType>

    init(results: Array<DeeplinkType> = []) {
        self.results = results
    }

    func deeplinks() -> Observable<Array<DeeplinkType>> {
        return Observable.just(results)
    }
}
