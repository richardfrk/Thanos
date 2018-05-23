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
import Hero

class THHomeViewController: THCollectionViewController {
    
    // ViewModel
    let viewModel = THHomeViewModel()

    // DisposeBag
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        viewModel.characters
            .asObservable()
            .bind(to: collectionView!.rx.items(
                cellIdentifier: THCollectionViewCell.identifier,
                cellType: THCollectionViewCell.self)) { row, element, cell in
                    cell.configure(from: element)
                    print(element.id)
            }
            .disposed(by: disposeBag)
        
        collectionView!.rx.itemSelected
            .subscribe(onNext: { indexPath in
                let cell = self.collectionView!.cellForItem(at: indexPath) as! THCollectionViewCell
                cell.customView.coverImage.hero.id = String(indexPath.item)
                if let controller = self.storyboard?.instantiateViewController(withIdentifier: "THDetailViewController") as? THDetailViewController {
                    controller.heroIdentifier = cell.customView.coverImage.hero.id
                    let comics = self.viewModel.comics(byIndexPath: indexPath)
                    let thumbnail = self.viewModel.thumbnail(byIndexPath: indexPath)
                    controller.viewModel.comics.accept(comics)
                    controller.viewModel.thumbnail?.accept(thumbnail)
                    self.present(controller, animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
    }
}


