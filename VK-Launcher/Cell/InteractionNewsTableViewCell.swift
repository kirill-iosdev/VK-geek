//
//  InteractionNewsTableViewCell.swift
//  VK-Launcher
//
//  Created by Kirill on 29.05.2022.
//

import UIKit

class InteractionNewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var likesCounterLabel: UILabel!
    @IBOutlet weak var commentsCounterLabel: UILabel!
    @IBOutlet weak var sharedCounterLabel: UILabel!
    @IBOutlet weak var watchCounterLabel: UILabel!
    @IBOutlet weak var eyeImageView: UIImageView!
    
    @IBAction func likeButton(_ sender: Any) {
    }
    
    @IBAction func commentButton(_ sender: Any) {
    }
    
    @IBAction func shareButton(_ sender: Any) {
    }
}
