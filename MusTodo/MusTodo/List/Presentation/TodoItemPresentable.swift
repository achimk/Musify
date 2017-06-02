//
//  TodoItemPresentable.swift
//  MusTodo
//
//  Created by Joachim Kret on 01/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

protocol TodoItemPresentable: TodoConvertible {
    var attributedText: NSAttributedString { get }
    var isDone: Bool { get }
}
