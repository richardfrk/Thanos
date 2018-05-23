//
//  THMarvelAPI.swift
//  Thanos
//
//  Created by Richard Frank on 22/05/2018.
//  Copyright © 2018 Richard Frank. All rights reserved.
//

import Foundation
import Moya
import CryptoSwift

enum THMarvelAPI {
    case characters
    case character(id: Int)
}

struct THMarvelAPIAuth {
    static let timestamp = Date().description
    static let hashValue = (THMarvelAPIAuth.timestamp +
        THMarvelAPI.PRIVATE_KEY + THMarvelAPI.PUBLIC_KEY).md5()
}

extension THMarvelAPI: TargetType {
    
    static var PUBLIC_KEY = "ddbcc65118c15497d3259b16e47879b9"
    static var PRIVATE_KEY = "6cb9c0671bd34d57332ea6a2f715c2c8b34da908"
    
    var baseURL: URL {
        return URL(string: "https://gateway.marvel.com:443")!
    }
    
    var path: String {
        switch self {
        case .characters:
            return "/v1/public/characters"
        case .character(let id):
            return "/v1/public/characters/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .characters, .character:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .characters, .character:
            return .requestParameters(parameters: authParameters(),
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    /// Custom Function
    func authParameters() -> [String: Any] {
        return [
            "ts": THMarvelAPIAuth.timestamp,
            "hash": THMarvelAPIAuth.hashValue,
            "apikey": THMarvelAPI.PUBLIC_KEY
        ]
    }
}
