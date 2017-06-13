//
//  PlaylistsFeature.swift
//  Musify
//
//  Created by Joachim Kret on 13/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusUI
import MusServices
import FeaturePlaylist

struct PlaylistsFeature: FlowPresentable {
    let servicePlaylists: PlaylistServiceType

    init(servicePlaylists: PlaylistServiceType) {
        self.servicePlaylists = servicePlaylists
    }

    func present(using presenter: ViewControllerPresentable) {
        let dependencies: PlaylistsModuleDependencies
        dependencies = servicePlaylists
        let controller = PlaylistsModuleBuilder(dependencies).build()
        controller.title = "Playlists"
        presenter.present(viewController: controller)
    }
}
