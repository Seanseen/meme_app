//
//  HomeCell.swift
//  meme_app
//
//  Created by tienhugn__ on 17/5/24.
//

import UIKit

class HomeCell: UICollectionViewCell {

    @IBOutlet weak var underVIew: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
    }

}
