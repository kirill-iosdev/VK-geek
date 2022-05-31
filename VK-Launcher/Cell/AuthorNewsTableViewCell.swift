//
//  AuthorNewsTableViewCell.swift
//  VK-Launcher
//
//  Created by Kirill on 29.05.2022.
//

import UIKit

class AuthorNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        
    }
    
    private func setupUI() {
        avatarImageView.layer.cornerRadius = 30
    }
    
    override func prepareForReuse() {
        
    }
    
    func configure() {
        avatarImageView.image = UIImage(named: "geekbrains")
        nameLabel.text = "Geekbrains"
        dateLabel.text = "29 мая в 18:15"
    }
}
