//
//  PlaylistsViewController.swift
//  Musify
//
//  Created by Joachim Kret on 01/05/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import MusServices

final class PlaylistsViewController: UIViewController {
    fileprivate let tableView: UITableView
    fileprivate let viewModel: PlaylistsViewModelType
    fileprivate let disposeBag = DisposeBag()
    fileprivate var playlists: Array<PlaylistPresentable> = []

    init(service: PlaylistServiceType) {
        self.tableView = UITableView(frame: CGRect.zero, style: .grouped)
        self.viewModel = PlaylistsViewModel(service: service)
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
        setupNavigationItems()
        setupTableView()
        setupBindings()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    @IBAction func playlistInput() {
        let alert = UIAlertController(
            title: "Playlist",
            message: "Please input playlist name:",
            preferredStyle: UIAlertControllerStyle.alert
        )

        alert.addAction(UIAlertAction(title: "Add", style: UIAlertActionStyle.default, handler: { [weak self] action in
            guard let text = alert.textFields?.first?.text else { return }
            self?.add(playlistWithName: text)
        }))
        alert.addTextField(configurationHandler: {(textField: UITextField) in
            textField.placeholder = "Name..."
        })

        present(alert, animated: true, completion: nil)
    }

    private func setupNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(PlaylistsViewController.playlistInput)
        )
    }

    private func setupTableView() {
        tableView.register(cellType: PlaylistTableViewCell.self)

        tableView.delegate = self
        tableView.dataSource = self

        tableView.translatesAutoresizingMaskIntoConstraints = true
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }

    private func setupBindings() {
        viewModel.outputs.onPlaylists.drive(onNext: { [weak self] items in
            self?.playlists = items
            self?.tableView.reloadData()
        }).addDisposableTo(disposeBag)
    }

    private func add(playlistWithName name: String) {
        guard name.characters.count > 0 else { return }
        let playlist = Playlist(name: name)
        viewModel.inputs.add(playlist: playlist)
    }
}

extension PlaylistsViewController: UITableViewDelegate {
}

extension PlaylistsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlaylistTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setup(using: playlists[indexPath.item])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let playlist = playlists[indexPath.item].asPlaylist()
            viewModel.inputs.remove(playlist: playlist)
        }
    }
}
