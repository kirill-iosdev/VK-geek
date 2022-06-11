//
//  MyGroupsViewController.swift
//  VK-Launcher
//
//  Created by Kirill on 19.02.2022.
//

import UIKit

class MyGroupsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let reuseIdentifier = "reuseIdentifier"
    var myGroupsArray = [Group]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(allGroupRowPress(_:)), name: allGroupsRowPressed, object: nil)
    }
    
    @objc func allGroupRowPress(_ notification: Notification) {
        guard let group = notification.object as? Group else { return }
        if !isContain(group: group) {
            myGroupsArray.append(group)
        }
    }
    
    func isContain(group: Group) -> Bool {
        return myGroupsArray.contains { groupItem in
            groupItem.name == group.name
        }
    }
}

extension MyGroupsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension MyGroupsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        cell.configure(group: myGroupsArray[indexPath.row])
        return cell
    }
}
