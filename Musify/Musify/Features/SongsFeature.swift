//
//  SongsFeature.swift
//  Musify
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusUI
import MusServices
import FeatureSongs

struct SongsFeature: FlowPresentable {
    let serviceSongs: SongsServiceType
    let album: AlbumType

    init(serviceSongs: SongsServiceType, album: AlbumType) {
        self.serviceSongs = serviceSongs
        self.album = album
    }

    func present(using presenter: ViewControllerPresentable) {
        let dependencies: SongsModuleDependencies
        dependencies.album = album
        dependencies.service = serviceSongs

        let controller = SongsModuleBuilder(dependencies).build()
        controller.title = "Songs"
        presenter.present(viewController: controller)
    }
}
