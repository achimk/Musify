//
//  TopArtistsService.swift
//  MusServices
//
//  Created by Joachim Kret on 18/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift

public protocol ArtistsServiceType {
    func topArtists() -> Observable<Array<ArtistType>>
}
