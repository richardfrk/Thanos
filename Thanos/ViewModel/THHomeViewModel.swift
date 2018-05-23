//
//  THHomeViewModel.swift
//  Thanos
//
//  Created by Richard Frank on 22/05/2018.
//  Copyright © 2018 Richard Frank. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

class THHomeViewModel {
    
    let disposeBag = DisposeBag()
    var characters = BehaviorRelay<[THCharacter]>(value: [])
    
    init() {
        loadData()
    }
    
    private func loadData() {
            let provider = MoyaProvider<THMarvelAPI>()
            provider.rx
                .request(.characters)
                .subscribe { event in
                    switch event {
                    case .success(let element):
                        do {
                            let response = try element.map(THResponse.self)
                            self.characters.accept(response.data.results)
                        } catch {
                            self.characters.accept([])
                        }
                    case .error(let error):
                        print(error)
                    }
                }
                .disposed(by: disposeBag)
    }
    
    func comics(byIndexPath indexPath: IndexPath) -> [THComicsItem] {
        return characters.value[indexPath.item].comics.items
    }
    
    func thumbnail(byIndexPath indexPath: IndexPath) -> THThumbnail {
        return characters.value[indexPath.item].thumbnail
    }
}

