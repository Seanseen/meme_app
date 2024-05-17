//
//  HomeScreenController.swift
//  meme_app
//
//  Created by tienhugn__ on 16/5/24.
//

import Foundation
import UIKit

class HomeScreenController: UIViewController {
    
    @IBOutlet weak var memesView: UICollectionView!
    let friends = ["Ace", "Angela", "David", "John", "Tom", "Lana", "Linlin", "Susan"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Memes")
        memesView.register(UINib(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
        memesView.delegate = self
        memesView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        memesView.collectionViewLayout.invalidateLayout()
    }
}

extension HomeScreenController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friends.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print(indexPath.section)
        guard let cell = memesView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as? HomeCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        let friend = friends[indexPath.row]
        cell.avatarImageView.image = UIImage(named: friend)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}
