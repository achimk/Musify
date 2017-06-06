//
//  TopArtistsViewController.swift
//  ModuleTopArtists
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

final class TopArtistsViewController: UIViewController {
    fileprivate let tableView: UITableView
    fileprivate var artists: Array<TopArtistPresentable> = []
    fileprivate var appearsFirstTime = true

    var presenter: TopArtistsPresenterInputs!

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
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.viewDidDisappear(animated)

        if appearsFirstTime {
            appearsFirstTime = false
            presenter.request()
        }
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
        tableView.register(cellType: TopArtistTableViewCell.self)

        tableView.delegate = self
        tableView.dataSource = self

        tableView.translatesAutoresizingMaskIntoConstraints = true
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }
}

extension TopArtistsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let artist = artists[indexPath.item].asArtist()
        presenter.present(artist: artist)
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


extension TopArtistsViewController: TopArtistsPresenterOutputs {
    func present(_ items: Array<TopArtistPresentationItem>) {
        artists = items
        tableView.reloadData()
    }
}

