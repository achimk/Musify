//
//  PlaylistTableViewCell.swift
//  Musify
//
//  Created by Joachim Kret on 01/05/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import Reusable

final class PlaylistTableViewCell: UITableViewCell, Reusable {
    func setup(using item: PlaylistPresentable?) {
        textLabel?.attributedText = item?.attributedName
    }
}
