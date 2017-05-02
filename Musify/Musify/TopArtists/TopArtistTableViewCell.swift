//
//  TopArtistTableViewCell.swift
//  Musify
//
//  Created by Joachim Kret on 18/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import Reusable

final class TopArtistTableViewCell: UITableViewCell, Reusable {
    func setup(using item: TopArtistPresentable?) {
        textLabel?.attributedText = item?.attributedName
    }
}
