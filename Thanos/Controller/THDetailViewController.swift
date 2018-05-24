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

class THDetailViewController: THViewController {
    
    // IBOutlets
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    // Variables
    public var heroIdentifier: String!
    
    // ViewModel
    public var viewModel = THDetailViewModel()
    
    // DisposeBag
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHero()
        setupImageView()
        setupTableView()
    }
    
    private func setupHero() {
        coverImage.hero.id = heroIdentifier
        view.hero.modifiers = [.fade,.translate(y:100)]
    }
    
    private func setupImageView() {
        viewModel.thumbnail
            .asObservable()
            .observeOn(MainScheduler.instance)
            .map({ (URL(string: $0 + ".jpg")!) })
            .bind(to: self.coverImage.kf.rx.image())
            .disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        viewModel.comics
            .asObservable()
            .observeOn(MainScheduler.instance)
            .bind(to: self.tableView.rx.items(
                cellIdentifier: THTableViewCell.identifier)) { row, element, cell in
                    cell.textLabel?.text = element.name
            }
            .disposed(by: disposeBag)
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
