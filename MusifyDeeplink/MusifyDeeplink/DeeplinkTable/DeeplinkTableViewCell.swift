//
//  DeeplinkTableViewCell.swift
//  MusifyDeeplink
//
//  Created by Joachim Kret on 08/04/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import Reusable

final class DeeplinkTableViewCell: UITableViewCell, Reusable {
    func setup(using item: DeeplinkPresentable) {
        textLabel?.attributedText = item.attributedName
    }
}
