//
//  ListViewController.swift
//  MusTodo
//
//  Created by Joachim Kret on 01/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

final class ListViewController: UIViewController {
    var presenter: ListPresenterInputs!

    init() {
        /*
         Inject additional dependencies here
         */
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("['] \(type(of: self))")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.viewDidDisappear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.viewDidDisappear(animated)
    }

}

extension ListViewController: ListPresenterOutputs {
    /*
     Implement ListPresenterOutputs protocol
     */
}

