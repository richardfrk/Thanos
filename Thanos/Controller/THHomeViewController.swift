//
//  THHomeViewController.swift
//  Thanos
//
//  Created by Richard Frank on 22/05/2018.
//  Copyright © 2018 Richard Frank. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class THHomeViewController: UICollectionViewController {
    
    let viewModel = THHomeViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.dataSource = nil
        collectionView?.delegate = nil
        setupUI()
    }
    
    private func setupUI() {
        viewModel.characters
            .asObservable()
            .bind(to: collectionView!.rx.items(
                cellIdentifier: THCollectionViewCell.identifier,
                cellType: THCollectionViewCell.self)) { row, element, cell in
                    cell.configure(from: element)
            }
            .disposed(by: disposeBag)
    }
}


