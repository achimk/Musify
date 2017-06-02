//
//  TodoTableViewCell.swift
//  MusTodo
//
//  Created by Joachim Kret on 01/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

final class TodoTableViewCell: UITableViewCell {
    func configure(using item: TodoItemPresentable) {
        self.textLabel?.attributedText = item.attributedText
        self.accessoryType = item.isDone ? .checkmark : .none
    }
}
