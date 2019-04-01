//
//  MenuViewController.swift
//  Ahitat
//
//  Created by Daniel Szasz on 9/14/18.
//  Copyright © 2018 Daniel Szasz. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var versionLabel: UILabel!
    @IBOutlet private weak var separatorView: UIView!
    @IBOutlet private weak var tableView: UITableView!

    private weak var delegate: MainDelegate?

    private var models: [MenuTableViewCell.ViewModel] = []

    init(delegate: MainDelegate) {
        self.delegate = delegate
        super.init(nibName: "MenuViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        generateModels()
        separatorView.backgroundColor = .iceBlue

        titleLabel.textColor = .slateTwo
        titleLabel.font = UIFont.menuTitleLabel.changeSizeIfIpad
        titleLabel.text = "Áhitat"

        versionLabel.textColor = .slateTwo
        versionLabel.font = UIFont.versionFont.changeSizeIfIpad
        versionLabel.text = Bundle.main.getVersionString()

        let nib = UINib(nibName: "MenuTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MenuTableViewCell")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 21, bottom: 0, right: 14)
        tableView.separatorColor = .iceBlue
        tableView.delegate = self
        tableView.dataSource = self

        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    private func generateModels() {
        let first = MenuTableViewCell.ViewModel.init(image: #imageLiteral(resourceName: "iconBible.png"), title: "Online Biblia")
        let second = MenuTableViewCell.ViewModel.init(image: #imageLiteral(resourceName: "iconBookmarks.png"), title: "Kedvencek")
        let third = MenuTableViewCell.ViewModel.init(image: #imageLiteral(resourceName: "iconHelp.png"), title: "Segítség")
        let fourth = MenuTableViewCell.ViewModel.init(image: #imageLiteral(resourceName: "iconInfo.png"), title: "Az Áhitat App-ról")
        models = [first, second, third, fourth]
    }
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            openBibleLink()
        case 1:
            openFavorites()
        case 2:
            openHelp()
        default:
            break
        }

        tableView.deselectRow(at: indexPath, animated: false)
    }

    private func openHelp() {
        let vc = HelpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func openBibleLink() {
        let uri = "http://www.abibliamindenkie.hu"
        guard let url = URL(string: uri),
            UIApplication.shared.canOpenURL(url) else {return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    private func openFavorites() {
        guard let delegate = delegate else {return}
        let vc = FavoritesTableViewController(delegate: delegate)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MenuViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        cell.configure(with: models[indexPath.row])

        return cell
    }
}
