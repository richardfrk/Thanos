//
//  THResponse.swift
//  Thanos
//
//  Created by Richard Frank on 22/05/2018.
//  Copyright © 2018 Richard Frank. All rights reserved.
//

import Foundation

struct THResponse: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: THData
}

struct THData: Codable {
    let offset, limit, total, count: Int
    let results: [THCharacter]
}

struct THCharacter: Codable {
    let id: Int
    let name, description, modified: String
    let thumbnail: THThumbnail
    let resourceURI: String
    let comics, series: THComics
    let stories: THStories
    let events: THComics
    let urls: [THURL]
}

struct THComics: Codable {
    let available: Int
    let collectionURI: String
    let items: [THComicsItem]
    let returned: Int
}

struct THComicsItem: Codable {
    let resourceURI, name: String
}

struct THStories: Codable {
    let available: Int
    let collectionURI: String
    let items: [THStoriesItem]
    let returned: Int
}

struct THStoriesItem: Codable {
    let resourceURI, name: String
    let type: THItemType
}

enum THItemType: String, Codable {
    case cover = "cover"
    case empty = ""
    case interiorStory = "interiorStory"
    case pinup = "pinup"
}

struct THThumbnail: Codable {
    let path: String
    let thumbnailExtension: THExtension
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum THExtension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
}

struct THURL: Codable {
    let type: THURLType
    let url: String
}

enum THURLType: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}


