//
//  TodoView.swift
//  MusTodo
//
//  Created by Joachim Kret on 02/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

final class TodoView: UITableViewCell {
    var onTapAction: ((Void) -> Void)?

    convenience init() {
        self.init(style: .default, reuseIdentifier: "")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        bindGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        unbindGesture()
    }

    func bindGesture() {
        let sel = #selector(TodoView.tap)
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: sel)
        contentView.addGestureRecognizer(gesture)
    }

    func unbindGesture() {
        let gestures = contentView.gestureRecognizers ?? []
        for gesture in gestures {
            contentView.removeGestureRecognizer(gesture)
        }
    }

    @IBAction func tap() {
        onTapAction?()
    }
}
