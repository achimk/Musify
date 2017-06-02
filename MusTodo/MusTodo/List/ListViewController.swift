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
//    fileprivate var items: Array<TodoItemPresentable> = []
    fileprivate var viewModels: Array<TodoViewModelType> = []
    fileprivate let tableView: UITableView
    var presenter: ListPresenterInputs!

    init() {
        self.tableView = UITableView(frame: CGRect.zero, style: .grouped)
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

        configureTableView()
        configureNavigationItems()

        presenter.viewDidLoad()
        presenter.reload()
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

    @IBAction func presentInput() {
        let alert = UIAlertController(
            title: "Task",
            message: "Please enter task description:",
            preferredStyle: UIAlertControllerStyle.alert
        )

        alert.addAction(UIAlertAction(title: "Add", style: UIAlertActionStyle.default, handler: { [weak self] action in
            guard let text = alert.textFields?.first?.text else { return }
            self?.presenter.add(withText: text)
        }))
        alert.addTextField(configurationHandler: {(textField: UITextField) in
            textField.placeholder = "Description..."
        })

        present(alert, animated: true, completion: nil)
    }

    private func configureTableView() {
        tableView.register(ContainerTableViewCell.self, forCellReuseIdentifier: "TodoCell")

        tableView.delegate = self
        tableView.dataSource = self

        tableView.translatesAutoresizingMaskIntoConstraints = true
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }

    private func configureNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(ListViewController.presentInput)
        )
    }
}

extension ListViewController: ListPresenterOutputs {
    func present(viewModels: Array<TodoViewModelType>) {
        self.viewModels = viewModels
        tableView.reloadData()
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select: \(indexPath.item)")
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as? ContainerTableViewCell
        cell?.viewModel = viewModels[indexPath.item]
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
}

