//
//  ImageNewsTableViewCell.swift
//  VK-Launcher
//
//  Created by Kirill on 29.05.2022.
//

import UIKit

class ImageNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        newsImageView.image = UIImage(named: "it")
    }
    
}
