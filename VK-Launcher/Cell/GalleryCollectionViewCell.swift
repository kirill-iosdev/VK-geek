//
//  GalleryCollectionViewCell.swift
//  VK-Launcher
//
//  Created by Kirill on 19.02.2022.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var fotoImageView: UIImageView!
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var counterLabel: UILabel!
    
    var count = 0
    var isHeartPressed = false
    
    func configure(image: Gallery) {
        let imageUrl = URL(string: image.url)
        if let data = try? Data(contentsOf: imageUrl!) {
            fotoImageView.image = UIImage(data: data)
        }
    }
//    func configure(image: UIImage?) {
//        fotoImageView.image = image
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        fotoImageView.image = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        counterLabel.text = String(self.count)
        heartState(isFilled: false)
    }
    
    func heartState(isFilled: Bool) {
        var heartImage = UIImage(systemName: "heart")
        if isFilled {
            heartImage = UIImage(systemName: "heart.fill")
        }
        self.heartImageView.image = heartImage
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        isHeartPressed = !isHeartPressed
        heartState(isFilled: isHeartPressed)
        if isHeartPressed {
            self.count += 1
            UIView.transition(with: counterLabel, duration: 1, options: .transitionFlipFromLeft) { [weak self] in
                self?.counterLabel.text = String(self!.count)
            }
        } else {
            self.count -= 1
            UIView.transition(with: counterLabel, duration: 1, options: .transitionFlipFromLeft) { [weak self] in
                self?.counterLabel.text = String(self!.count)
            }
        }
    }
}
