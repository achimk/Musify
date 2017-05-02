//
//  SongsFlow.swift
//  Musify
//
//  Created by Joachim Kret on 18/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusUI
import MusServices

struct SongsFlow: FlowPresentable {
    let serviceSongs: SongsServiceType
    let album: AlbumType

    init(serviceSongs: SongsServiceType, album: AlbumType) {
        self.serviceSongs = serviceSongs
        self.album = album
    }

    func present(using presenter: ViewControllerPresentable) {
        let controller = SongsViewController(service: serviceSongs, album: album)
        controller.title = "Songs"
        presenter.present(viewController: controller)
    }
}
