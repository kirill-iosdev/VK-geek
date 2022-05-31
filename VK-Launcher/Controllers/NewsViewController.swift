//
//  NewsViewController.swift
//  VK-Launcher
//
//  Created by Kirill on 29.05.2022.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        registerCells()
        tableView.separatorStyle = .none
        
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: "AuthorNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell1")
        tableView.register(UINib(nibName: "TextNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell2")
        tableView.register(UINib(nibName: "ImageNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell3")
        tableView.register(UINib(nibName: "InteractionNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell4")
    }
}

extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 70
        case 1:
            return 250
        case 2:
            return 250
        case 3:
            return 70
        default:
            return 70
        }
    }
}

extension NewsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as? AuthorNewsTableViewCell else { return UITableViewCell() }
            cell.configure()
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as? TextNewsTableViewCell else { return UITableViewCell() }
            cell.configure()
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as? ImageNewsTableViewCell else { return UITableViewCell() }
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell4", for: indexPath) as? InteractionNewsTableViewCell else { return UITableViewCell() }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
