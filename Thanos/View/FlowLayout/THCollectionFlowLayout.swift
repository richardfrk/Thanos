//
//  THCustomFlowLayout.swift
//  Thanos
//
//  Created by Richard Frank on 23/05/2018.
//  Copyright © 2018 Richard Frank. All rights reserved.
//

import UIKit

class THCollectionFlowLayout: UICollectionViewFlowLayout {
    
    let multiplier: CGFloat = 1.63
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    func setupLayout() {
        let customW = UIScreen.main.bounds.width - 24
        itemSize = CGSize(width: customW, height: customW / multiplier)
        sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
}
