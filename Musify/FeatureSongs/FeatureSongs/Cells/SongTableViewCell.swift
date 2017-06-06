//
//  SongTableViewCell.swift
//  FeatureSongs
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import Reusable

final class SongTableViewCell: UITableViewCell, Reusable {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(using item: SongPresentable?) {
        textLabel?.attributedText = item?.attributedName
        detailTextLabel?.attributedText = item?.attributedLength
    }
}
