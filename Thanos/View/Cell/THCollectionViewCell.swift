//
//  THCollectionViewCell.swift
//  Thanos
//
//  Created by Richard Frank on 23/05/2018.
//  Copyright © 2018 Richard Frank. All rights reserved.
//

import UIKit
import Kingfisher

class THCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "THCollectionViewCell"
    
    @IBOutlet weak var customView: THCustomView!
    
    func configure(from element: THCharacter) {
        let url = URL(string: element.thumbnail.path + ".jpg")
        customView.coverImage.kf.setImage(with: url)
        customView.nameLabel.text = element.name
    }
}
