//
//  NewsViewController.swift
//  VK-Launcher
//
//  Created by Kirill on 29.05.2022.
//

import UIKit
import RealmSwift

class NewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var news = try? Realm().objects(News.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        registerCells()
        tableView.separatorStyle = .none
        
        let networkService = NetworkService()
        networkService.getNews() { [weak self] news in
            try? RealmService.save(items: news)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: "AuthorNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "authorCell")
        tableView.register(UINib(nibName: "TextNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "textCell")
        tableView.register(UINib(nibName: "ImageNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "imageCell")
        tableView.register(UINib(nibName: "InteractionNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "interactionCell")
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
        news?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "authorCell", for: indexPath) as? AuthorNewsTableViewCell else { return UITableViewCell() }
            cell.configure()
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as? TextNewsTableViewCell,
                  let news = news?[indexPath.item]  else { return UITableViewCell() }
            cell.configure(news: news)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? ImageNewsTableViewCell else { return UITableViewCell() }
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "interactionCell", for: indexPath) as? InteractionNewsTableViewCell else { return UITableViewCell() }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
