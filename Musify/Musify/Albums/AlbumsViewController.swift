//
//  AlbumsViewController.swift
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

final class AlbumsViewController: UIViewController {
    fileprivate let tableView: UITableView
    fileprivate let viewModel: AlbumsViewModelType
    fileprivate let disposeBag = DisposeBag()
    fileprivate let onSelectAlbum: ((AlbumType) -> Void)?
    fileprivate var albums: Array<AlbumPresentable> = []
    
    init(service: AlbumsServiceType, artist: ArtistType, onSelectAlbum: ((AlbumType) -> Void)? = nil) {
        self.tableView = UITableView(frame: CGRect.zero, style: .grouped)
        self.viewModel = AlbumsViewModel(service: service, artist: artist)
        self.onSelectAlbum = onSelectAlbum
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
        tableView.register(cellType: AlbumTableViewCell.self)

        tableView.delegate = self
        tableView.dataSource = self

        tableView.translatesAutoresizingMaskIntoConstraints = true
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }

    private func setupBindings() {
        viewModel.outputs.onAlbums.drive(onNext: { [weak self] items in
            self?.albums = items
            self?.tableView.reloadData()
        }).addDisposableTo(disposeBag)
    }
}

extension AlbumsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelectAlbum?(albums[indexPath.item].asAlbum())
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
