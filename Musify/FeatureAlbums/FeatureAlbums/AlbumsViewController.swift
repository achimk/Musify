//
//  AlbumsViewController.swift
//  FeatureAlbums
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

final class AlbumsViewController: UIViewController {
    fileprivate let tableView: UITableView
    fileprivate var albums: Array<AlbumPresentable> = []
    fileprivate var appearsFirstTime = true

    var presenter: AlbumsPresenterInputs!

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
        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear(animated)

        if appearsFirstTime {
            presenter.request()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear(animated)
        appearsFirstTime = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.viewDidDisappear(animated)
    }

    private func configureTableView() {
        tableView.register(cellType: AlbumTableViewCell.self)

        tableView.delegate = self
        tableView.dataSource = self

        tableView.translatesAutoresizingMaskIntoConstraints = true
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }
}

extension AlbumsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = albums[indexPath.item].asAlbum()
        presenter.present(album: album)
    }
}

extension AlbumsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AlbumTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setup(using: albums[indexPath.item])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
}

extension AlbumsViewController: AlbumsPresenterOutputs {
    func present(_ items: Array<AlbumPresentable>) {
        albums = items
        tableView.reloadData()
    }
}

