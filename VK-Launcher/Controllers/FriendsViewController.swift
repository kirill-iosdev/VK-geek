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
    private var photoService: PhotoService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "reuseIdentifier")
        
        photoService = PhotoService(container: tableView)
        
        let networkService = NetworkService()
        
        networkService.getUrl()
            .then(on: DispatchQueue.global(), networkService.getData(_:))
            .then(on: DispatchQueue.global(), networkService.getParsedData(_:))
            .done(on: DispatchQueue.main) { friends in
                self.tableView.reloadData()
            }.catch { error in
                print(error)
            }
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
        tableView.deselectRow(at: indexPath, animated: true)
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
        let image = photoService?.photo(atIndexPath: indexPath, byUrl: friend.photo50)
        cell.configure(friend: friend, image: image)
        return cell
    }
}
