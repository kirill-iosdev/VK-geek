//
//  AllGroupsController.swift
//  VK-Launcher
//
//  Created by Kirill on 12.02.2022.
//

import UIKit
import RealmSwift

class AllGroupsController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private lazy var groups = try? Realm().objects(Group.self)
    private var photoService: PhotoService?
    private let reuseIdentifier = "reuseIdentifier"
    lazy var sourceGroupsArray = groups
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        photoService = PhotoService(container: tableView)
        photoService = PhotoService(container: tableView)
        groups = sourceGroupsArray
        
        let networkService = NetworkService()
        networkService.getGroupsList { [weak self] groups in
            try? RealmService.save(items: groups)
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension AllGroupsController: UISearchBarDelegate {
    
    //    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    //
    //        if searchText.isEmpty {
    //            groupsArray = sourceGroupsArray
    //        }
    //        else {
    //            groupsArray = sourceGroupsArray.filter({ groupItem in
    //                groupItem.name.lowercased().contains(searchText.lowercased())
    //            })
    //        }
    //        tableView.reloadData()
    //    }
}

extension AllGroupsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: allGroupsRowPressed, object: groups?[indexPath.item])
    }
}

extension AllGroupsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CustomTableViewCell,
              let group = groups?[indexPath.item] else { return UITableViewCell() }
        let image = photoService?.photo(atIndexPath: indexPath, byUrl: group.photo50)
        cell.configure(group: group, image: image)
        return cell
    }
}

