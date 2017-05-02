//
//  TopArtistsViewController.swift
//  Musify
//
//  Created by Joachim Kret on 18/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit
import Reusable
import RxSwift
import RxCocoa
import MusServices

final class TopArtistsViewController: UIViewController {
    fileprivate let tableView: UITableView
    fileprivate let viewModel: TopArtistsViewModelType
    fileprivate let disposeBag = DisposeBag()
    fileprivate let onSelectArtist: ((ArtistType) -> Void)?
    fileprivate var artists: Array<TopArtistPresentable> = []

    init(service: ArtistsServiceType, onSelectArtist: ((ArtistType) -> Void)? = nil) {
        self.tableView = UITableView(frame: CGRect.zero, style: .grouped)
        self.viewModel = TopArtistsViewModel(service: service)
        self.onSelectArtist = onSelectArtist
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
        tableView.register(cellType: TopArtistTableViewCell.self)

        tableView.delegate = self
        tableView.dataSource = self

        tableView.translatesAutoresizingMaskIntoConstraints = true
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }

    private func setupBindings() {
        viewModel.outputs.onArtists.drive(onNext: { [weak self] items in
            self?.artists = items
            self?.tableView.reloadData()
        }).addDisposableTo(disposeBag)
    }
}

extension TopArtistsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelectArtist?(artists[indexPath.item].asArtist())
    }
}

extension TopArtistsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TopArtistTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setup(using: artists[indexPath.item])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
}

