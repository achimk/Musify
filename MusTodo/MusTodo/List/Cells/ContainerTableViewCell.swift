//
//  ContainerTableViewCell.swift
//  MusTodo
//
//  Created by Joachim Kret on 02/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

final class ContainerTableViewCell: UITableViewCell {
    fileprivate let viewComponent = TodoView()

    var viewModel: TodoViewModelType? {
        willSet { unbind() }
        didSet {  bind(viewModel) }
    }


    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }

    func initialize() {
        viewComponent.translatesAutoresizingMaskIntoConstraints = true
        viewComponent.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewComponent.frame = contentView.bounds
        contentView.addSubview(viewComponent)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }

    private func bind(_ vm: TodoViewModelType?) {
        viewComponent.onTapAction = {
            vm?.inputs.toggle()
        }

        vm?.outputs.update = { [weak self] item in
            self?.viewComponent.textLabel?.attributedText = item.attributedText
            self?.viewComponent.accessoryType = item.isDone ? .checkmark : .none
        }
    }

    private func unbind() {
        viewComponent.onTapAction = nil
        viewComponent.textLabel?.attributedText = nil
        viewComponent.accessoryType = .none
    }
}
