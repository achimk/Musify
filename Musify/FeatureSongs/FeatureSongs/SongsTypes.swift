//
//  SongsTypes.swift
//  FeatureSongs
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusServices
import Result

public typealias SongsModuleDependencies = (album: AlbumType, service: SongsServiceType)

typealias SongsResult = Result<Array<SongType>, AnyError>
