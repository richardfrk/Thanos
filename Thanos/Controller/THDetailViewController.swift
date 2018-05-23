//
//  THDetailViewController.swift
//  Thanos
//
//  Created by Richard Frank on 23/05/2018.
//  Copyright © 2018 Richard Frank. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxKingfisher
import Hero

class THDetailViewController: THTableViewController {
    
    // IBOutlets
    @IBOutlet weak var coverImage: UIImageView!
    
    // Variables
    public var heroIdentifier: String!
    
    // ViewModel
    public var viewModel = THDetailViewModel()
    
    // DisposeBag
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHero()
        setupUI()
        setupTableView()
    }
    
    private func setupHero() {
        coverImage.hero.id = heroIdentifier
        view.hero.modifiers = [.fade,.translate(y:100)]
    }
    
    private func setupUI() {
        viewModel.thumbnail?
            .asObservable()
            .map({ (URL(string: $0.path + ".jpg")!) })
            .bind(to: self.coverImage.kf.rx.image())
            .disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        viewModel.comics
            .asObservable()
            .bind(to: self.tableView!.rx.items(
                cellIdentifier: THTableViewCell.identifier)) { row, element, cell in
                    cell.textLabel?.text = element.name
            }
            .disposed(by: disposeBag)
    }
}
