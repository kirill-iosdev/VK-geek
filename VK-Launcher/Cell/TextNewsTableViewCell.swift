//
//  TextNewsTableViewCell.swift
//  VK-Launcher
//
//  Created by Kirill on 29.05.2022.
//

import UIKit

class TextNewsTableViewCell: UITableViewCell {
    

    @IBOutlet weak var textNewsLabel: UILabel!
    
    func configure(news: News) {
        textNewsLabel.text = news.text
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textNewsLabel.text = nil
    }
}
