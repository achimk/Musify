//
//  TopArtistTableViewCell.swift
//  ModuleTopArtists
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import Reusable

final class TopArtistTableViewCell: UITableViewCell, Reusable {
    func setup(using item: TopArtistPresentable?) {
        textLabel?.attributedText = item?.attributedName
    }
}
