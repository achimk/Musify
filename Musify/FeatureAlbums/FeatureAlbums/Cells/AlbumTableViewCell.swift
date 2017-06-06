//
//  AlbumTableViewCell.swift
//  FeatureAlbums
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import Reusable

final class AlbumTableViewCell: UITableViewCell, Reusable {
    func setup(using item: AlbumPresentable?) {
        textLabel?.attributedText = item?.attributedName
    }
}
