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
import MusUI
import MusServices

final class AlbumsViewController: UIViewController {
    fileprivate let tableView: UITableView
    fileprivate let center: AlbumsEventsCenter
    fileprivate let disposeBag = DisposeBag()
    fileprivate var albums: Array<AlbumPresentable> = []
    
    init(center: AlbumsEventsCenter) {
        self.tableView = UITableView(frame: CGRect.zero, style: .grouped)
        self.center = center
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        tableView.delegate = nil
        tableView.dataSource = nil
        print("['] Controller deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        center.inputs.on(.request)
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
}

extension AlbumsViewController: EventHandling {
    func handle(_ event: AlbumsEvent.Output) -> Bool {
        switch event {
        case .present(let albums):
            self.albums = albums
            self.tableView.reloadData()
            return true
        }
    }
}

extension AlbumsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = albums[indexPath.item].asAlbum()
        center.inputs.on(.select(album: album))
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
