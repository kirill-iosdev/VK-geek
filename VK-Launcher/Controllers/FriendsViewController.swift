//
//  FriendsViewController.swift
//  VK-Launcher
//
//  Created by Kirill on 19.02.2022.
//

import UIKit
import RealmSwift

class FriendsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var friends = try? Realm().objects(Friend.self)
    private var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "reuseIdentifier")
      
        let networkService = NetworkService()
        networkService.getFriendsList() { [weak self] friends in
            try? RealmService.save(items: friends)
        }
        
//        friends = try? RealmService.get(Friend.self)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        notificationToken = friends?.observe({ [weak self] change in
            switch change {
            case.initial:
                self?.tableView.reloadData()
            case let .update(_, deletions, insertions, modifications):
                self?.tableView.update(deletions: deletions, insertions: insertions, modifications: modifications)
            case .error(let error):
                print(error)
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notificationToken?.invalidate()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromFriendsToGallery" {
            guard let destinationViewController = segue.destination as? GalleryViewController,
                  let photoArray = sender as? [Friend]
            else { return }
            destinationViewController.photoArray = photoArray
        }
    }
}

    extension FriendsViewController: UITableViewDelegate {
            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 70
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "fromFriendsToGallery", sender: nil)
        }
    }

    extension FriendsViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            friends?.count ?? 0
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? CustomTableViewCell,
              let friend = friends?[indexPath.item] else { return UITableViewCell() }
        cell.configure(friend: friend)
        return cell
    }
}
