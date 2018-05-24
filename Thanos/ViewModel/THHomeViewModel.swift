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
        ActivityNetwork.isVisible = true
        let provider = MoyaProvider<THMarvelAPI>()
        provider.rx
            .request(.characters)
            .subscribe(onSuccess: { [weak self] (response) in
                do {
                    let object = try response.map(THResponse.self)
                    self?.characters.accept(object.data.results)
                    ActivityNetwork.isVisible = false
                } catch {
                    self?.characters.accept([])
                    ActivityNetwork.isVisible = false
                }
            }, onError: { (error) in
                debugPrint(error)
            })
            .disposed(by: disposeBag)
    }
    
    func getCharacter(byName name: String) {
        ActivityNetwork.isVisible = true
        let provider = MoyaProvider<THMarvelAPI>()
        provider.rx
            .request(.character(name))
            .subscribe(onSuccess: { [weak self] (response) in
                do {
                    let object = try response.map(THResponse.self)
                    self?.characters.accept(object.data.results)
                    ActivityNetwork.isVisible = false
                } catch {
                    self?.characters.accept([])
                    ActivityNetwork.isVisible = false
                }
            }, onError: { (error) in
                debugPrint(error)
            })
            .disposed(by: disposeBag)
    }
    
    func comics(byIndexPath indexPath: IndexPath) -> [THComicsItem] {
        return characters.value[indexPath.item].comics.items
    }
    
    func thumbnail(byIndexPath indexPath: IndexPath) -> String {
        return characters.value[indexPath.item].thumbnail.path
    }
}

