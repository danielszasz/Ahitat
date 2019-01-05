//
//  FavoritesTableViewController.swift
//  Ahitat
//
//  Created by Daniel Szasz on 1/4/19.
//  Copyright © 2019 Daniel Szasz. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {

    private lazy var models: [FavoriteModel] = {
        return AhitatUserDefaults().getFavorites()
    }()

    private weak var delegate: MainDelegate?

    init(delegate: MainDelegate) {
        self.delegate = delegate
        super.init(style: .plain)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "FavoritesTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "FavoritesTableViewCell")
        tableView.tableFooterView = UIView()

        self.clearsSelectionOnViewWillAppear = true
        self.navigationItem.title = "Kedvencek"
        self.navigationItem.backBarButtonItem?.title = ""
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath) as! FavoritesTableViewCell

        cell.configure(model: models[indexPath.row])

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delete(at: indexPath)
        }
    }

    private func delete(at indexPath: IndexPath) {
        let modelToDelete = models[indexPath.row]
        AhitatUserDefaults().delete(model: modelToDelete)
        models.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = models[indexPath.row]
        self.navigationController?.popViewController(animated: true)
        delegate?.openMeditation(with: model.date, isAfterNoon: model.isAfternoon)
    }
}
