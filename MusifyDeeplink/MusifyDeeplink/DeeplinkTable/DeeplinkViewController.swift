//
//  DeeplinkViewController.swift
//  MusifyDeeplink
//
//  Created by Joachim Kret on 08/04/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class DeeplinkViewController: UIViewController {
    fileprivate let tableView: UITableView
    fileprivate let viewModel: DeeplinkViewModelType
    fileprivate let router: DeeplinkRoutable
    fileprivate let disposeBag = DisposeBag()
    fileprivate var deeplinks: Array<DeeplinkPresentable> = []

    init(service: DeeplinkServiceType, router: DeeplinkRoutable) {
        self.tableView = UITableView(frame: CGRect.zero, style: .grouped)
        self.viewModel = DeeplinkViewModel(service: service)
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        tableView.delegate = nil
        tableView.dataSource = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBindings()
    }

    private func setupTableView() {
        tableView.register(cellType: DeeplinkTableViewCell.self)

        tableView.delegate = self
        tableView.dataSource = self

        tableView.translatesAutoresizingMaskIntoConstraints = true
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }

    private func setupBindings() {
        viewModel.outputs.onDeeplinks.drive(onNext: { [weak self] items in
            self?.deeplinks = items
            self?.tableView.reloadData()
        }).addDisposableTo(disposeBag)
        viewModel.outputs.onDeeplinkURL.drive(onNext: { [weak self] url in
            self?.router.open(url)
        }).addDisposableTo(disposeBag)
    }
}

extension DeeplinkViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.inputs.deeplink(atIndex: indexPath.item)
    }
}

extension DeeplinkViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DeeplinkTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setup(using: deeplinks[indexPath.item])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deeplinks.count
    }
}
