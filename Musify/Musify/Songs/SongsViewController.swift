//
//  SongsViewController.swift
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

final class SongsViewController: UIViewController {
    fileprivate let tableView: UITableView
    fileprivate let viewModel: SongsViewModelType
    fileprivate let disposeBag = DisposeBag()
    fileprivate var songs: Array<SongPresentable> = []

    init(service: SongsServiceType, album: AlbumType) {
        self.tableView = UITableView(frame: CGRect.zero, style: .grouped)
        self.viewModel = SongsViewModel(service: service, album: album)
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
        tableView.register(cellType: SongTableViewCell.self)

        tableView.delegate = self
        tableView.dataSource = self

        tableView.translatesAutoresizingMaskIntoConstraints = true
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }

    private func setupBindings() {
        viewModel.outputs.onSongs.drive(onNext: { [weak self] items in
            self?.songs = items
            self?.tableView.reloadData()
        }).addDisposableTo(disposeBag)
    }
}

extension SongsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension SongsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SongTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setup(using: songs[indexPath.item])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
}
