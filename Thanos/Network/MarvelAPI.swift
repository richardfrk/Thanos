//
//  MarvelAPI.swift
//  Thanos
//
//  Created by Richard Frank on 22/05/2018.
//  Copyright © 2018 Richard Frank. All rights reserved.
//

import Foundation
import Moya
import CryptoSwift

enum MarvelAPI {
    case characters
}

struct MarvelAPIAuth {
    static let timestamp = Date().description
    static let hashValue = (MarvelAPIAuth.timestamp +
        MarvelAPI.PRIVATE_KEY + MarvelAPI.PUBLIC_KEY).md5()
}

extension MarvelAPI: TargetType {
    
    static var PUBLIC_KEY = "ddbcc65118c15497d3259b16e47879b9"
    static var PRIVATE_KEY = "6cb9c0671bd34d57332ea6a2f715c2c8b34da908"
    
    var baseURL: URL {
        return URL(string: "https://gateway.marvel.com:443")!
    }
    
    var path: String {
        switch self {
        case .characters:
            return "/v1/public/characters"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    var task: Task {
        return .requestParameters(parameters: authParameters(),
                                  encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    /// Custom Function
    func authParameters() -> [String: Any] {
        return [
            "ts": MarvelAPIAuth.timestamp,
            "hash": MarvelAPIAuth.hashValue,
            "apikey": MarvelAPI.PUBLIC_KEY
        ]
    }
}
