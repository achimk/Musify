//
//  PlaylistsFlow.swift
//  Musify
//
//  Created by Joachim Kret on 01/05/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusUI
import MusServices

struct PlaylistsFlow: FlowPresentable {
    let servicePlaylists: PlaylistServiceType

    init(servicePlaylists: PlaylistServiceType) {
        self.servicePlaylists = servicePlaylists
    }

    func present(using presenter: ViewControllerPresentable) {
        let controller = PlaylistsViewController(service: servicePlaylists)
        controller.title = "Playlists"
        presenter.present(viewController: controller)
    }
}
