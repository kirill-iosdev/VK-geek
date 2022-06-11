//
//  GalleryViewController.swift
//  VK-Launcher
//
//  Created by Kirill on 19.02.2022.
//

import UIKit
import RealmSwift

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let reuseIdentifier = "reuseIdentifier"
    var photoArray = [Friend]()
    var selectedFriend: Friend?
    private lazy var photos = try? Realm().objects(Gallery.self)
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //        let networkService = NetworkService()
        //        networkService.getPhotos(for: selectedFriend?.id ?? 0) { [weak self] photos in
        //            try? RealmService.save(items: photos)
        //        }
    }
}

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? GalleryCollectionViewCell,
              let photo = photos?[indexPath.item] else { return UICollectionViewCell()}
        cell.configure(image: photo)
        return cell
    }
}

extension GalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let view = UIView(frame: self.view.frame)
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let imageView = UIImageView(frame: view.frame)
        self.view.addSubview(view)
        view.addSubview(imageView)
        //imageView.image = UIImage(named: fotoArray[indexPath.item])
        imageView.contentMode = .scaleAspectFit
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2 - 5, height: collectionView.bounds.height / 2 - 5)
    }
}
