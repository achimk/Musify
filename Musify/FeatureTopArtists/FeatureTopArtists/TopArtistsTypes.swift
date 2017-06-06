//
//  TopArtistsTypes.swift
//  ModuleTopArtists
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusServices
import Result

public typealias TopArtistsModuleDependencies = ArtistsServiceType

typealias TopArtistsResult = Result<Array<ArtistType>, AnyError>
