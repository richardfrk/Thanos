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
        getCharacters()
    }
    
    func getCharacters() {
            let provider = MoyaProvider<THMarvelAPI>()
            provider.rx
                .request(.characters)
                .subscribe(onSuccess: { (response) in
                    do {
                        let object = try response.map(THResponse.self)
                        self.characters.accept(object.data.results)
                    } catch {
                        self.characters.accept([])
                    }
                }, onError: { (error) in
                    debugPrint(error)
                })
                .disposed(by: disposeBag)
    }
    
    func getCharacter(byName name: String) {
        let provider = MoyaProvider<THMarvelAPI>()
        provider.rx
            .request(.character(name))
            .subscribe(onSuccess: { (response) in
                do {
                    let object = try response.map(THResponse.self)
                    self.characters.accept(object.data.results)
                } catch {
                    self.characters.accept([])
                }
            }, onError: { (error) in
                debugPrint(error)
            })
            .disposed(by: disposeBag)
    }
    
    func comics(byIndexPath indexPath: IndexPath) -> [THComicsItem] {
        return characters.value[indexPath.item].comics.items
    }
    
    func thumbnail(byIndexPath indexPath: IndexPath) -> THThumbnail {
        return characters.value[indexPath.item].thumbnail
    }
}

