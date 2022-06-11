//
//  CustomTableViewCell.swift
//  VK-Launcher
//
//  Created by Kirill on 12.02.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var completion: (() -> Void)?
    
//    func configure(image: UIImage?, name: String?) {
//        avatarImageView.image = image
//        nameLabel.text = name
//    } //????
    
    func configure(group: Group) {
        let imageUrl = URL(string: group.photo50)
        if let data = try? Data(contentsOf: imageUrl!) {
            avatarImageView.image = UIImage(data: data)
        }
        nameLabel.text = group.name
    }
    
    func configure(friend: Friend) {
        let imageUrl = URL(string: friend.photo50)
        if let data = try? Data(contentsOf: imageUrl!) {
            avatarImageView.image = UIImage(data: data)
        }
        nameLabel.text = friend.firstName + " " + friend.lastName
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        nameLabel.text = nil
        completion = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        avatarImageView.layer.cornerRadius = 30
    }

    @IBAction func pressImageButton(_ sender: Any) {
        UIView.animate(withDuration: 1) { [weak self] in
            self?.avatarImageView.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
        } completion: { _ in
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 1, options: []) { [weak self] in
                self?.avatarImageView.transform = .identity
            } completion: { [weak self] _ in
                self?.completion?()
            }
        }
    }
}
