//
//  THDetailViewModel.swift
//  Thanos
//
//  Created by Richard Frank on 23/05/2018.
//  Copyright © 2018 Richard Frank. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class THDetailViewModel {
    
    let disposeBag = DisposeBag()
    var comics = BehaviorRelay<[THComicsItem]>(value: [])
    
}

