//
//  THCollectionViewController.swift
//  Thanos
//
//  Created by Richard Frank on 23/05/2018.
//  Copyright © 2018 Richard Frank. All rights reserved.
//

import UIKit

class THCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Disable dataSource and delegate.
        collectionView?.dataSource = nil
        collectionView?.delegate = nil
    }
}
