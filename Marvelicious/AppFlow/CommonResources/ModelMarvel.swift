//
//  ModelMarvel.swift
//  Marvelicious
//
//  Created by ANUJ NIGAM on 14/06/18.
//  Copyright © 2018 ANUJ NIGAM. All rights reserved.
//

import Foundation

//struct ModelMarvel : Codable {
//    let code : Int?
//    let status : String?
//    let copyright : String?
//    let attributionText : String?
//    let attributionHTML : String?
//    let etag : String?
//    let data1 : dataVal?
//    
//    enum CodingKeys: String, CodingKey {
//        
//        case code = "code"
//        case status = "status"
//        case copyright = "copyright"
//        case attributionText = "attributionText"
//        case attributionHTML = "attributionHTML"
//        case etag = "etag"
//        case data1 = "data"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        code = try values.decodeIfPresent(Int.self, forKey: .code)
//        status = try values.decodeIfPresent(String.self, forKey: .status)
//        copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
//        attributionText = try values.decodeIfPresent(String.self, forKey: .attributionText)
//        attributionHTML = try values.decodeIfPresent(String.self, forKey: .attributionHTML)
//        etag = try values.decodeIfPresent(String.self, forKey: .etag)
//        data1 = try values.decodeIfPresent(dataVal.self, forKey: .data1)
//    }
//}
//
//struct dataVal : Codable {
//    let offset : Int?
//    let limit : Int?
//    let total : Int?
//    let count : Int?
//    let results : [Results]?
//    
//    enum CodingKeys: String, CodingKey {
//        
//        case offset = "offset"
//        case limit = "limit"
//        case total = "total"
//        case count = "count"
//        case results = "results"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
//        limit = try values.decodeIfPresent(Int.self, forKey: .limit)
//        total = try values.decodeIfPresent(Int.self, forKey: .total)
//        count = try values.decodeIfPresent(Int.self, forKey: .count)
//        results = try values.decodeIfPresent([Results].self, forKey: .results)
//    }
//}
//
//struct Results : Codable {
//    let id : Int?
//    let digitalId : Int?
//    let title : String?
//    let issueNumber : Int?
//    let variantDescription : String?
//    let description : String?
//    let modified : String?
//    let isbn : String?
//    let upc : String?
//    let diamondCode : String?
//    let ean : String?
//    let issn : String?
//    let format : String?
//    let pageCount : Int?
//    let textObjects : [TextObjects]?
//    let resourceURI : String?
//    let urls : [Urls]?
//    let series : Series?
//    let variants : [Variants]?
//    //let collections : [String]?
//    //let collectedIssues : [String]?
//    let dates : [Dates]?
//    let prices : [Prices]?
//    let thumbnail : Thumbnail?
//    let images : [Images]?
//    let creators : Creators?
//    let characters : Characters?
//    let stories : Stories?
//    let events : Events?
//    
//    enum CodingKeys: String, CodingKey {
//        
//        case id = "id"
//        case digitalId = "digitalId"
//        case title = "title"
//        case issueNumber = "issueNumber"
//        case variantDescription = "variantDescription"
//        case description = "description"
//        case modified = "modified"
//        case isbn = "isbn"
//        case upc = "upc"
//        case diamondCode = "diamondCode"
//        case ean = "ean"
//        case issn = "issn"
//        case format = "format"
//        case pageCount = "pageCount"
//        case textObjects = "textObjects"
//        case resourceURI = "resourceURI"
//        case urls = "urls"
//        case series = "series"
//        case variants = "variants"
//        //case collections = "collections"
//        //case collectedIssues = "collectedIssues"
//        case dates = "dates"
//        case prices = "prices"
//        case thumbnail = "thumbnail"
//        case images = "images"
//        case creators = "creators"
//        case characters = "characters"
//        case stories = "stories"
//        case events = "events"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        digitalId = try values.decodeIfPresent(Int.self, forKey: .digitalId)
//        title = try values.decodeIfPresent(String.self, forKey: .title)
//        issueNumber = try values.decodeIfPresent(Int.self, forKey: .issueNumber)
//        variantDescription = try values.decodeIfPresent(String.self, forKey: .variantDescription)
//        description = try values.decodeIfPresent(String.self, forKey: .description)
//        modified = try values.decodeIfPresent(String.self, forKey: .modified)
//        isbn = try values.decodeIfPresent(String.self, forKey: .isbn)
//        upc = try values.decodeIfPresent(String.self, forKey: .upc)
//        diamondCode = try values.decodeIfPresent(String.self, forKey: .diamondCode)
//        ean = try values.decodeIfPresent(String.self, forKey: .ean)
//        issn = try values.decodeIfPresent(String.self, forKey: .issn)
//        format = try values.decodeIfPresent(String.self, forKey: .format)
//        pageCount = try values.decodeIfPresent(Int.self, forKey: .pageCount)
//        textObjects = try values.decodeIfPresent([TextObjects].self, forKey: .textObjects)
//        resourceURI = try values.decodeIfPresent(String.self, forKey: .resourceURI)
//        urls = try values.decodeIfPresent([Urls].self, forKey: .urls)
//        series = try values.decodeIfPresent(Series.self, forKey: .series)
//        variants = try values.decodeIfPresent([Variants].self, forKey: .variants)
//        //collections = try values.decodeIfPresent([String].self, forKey: .collections)
//        //collectedIssues = try values.decodeIfPresent([String].self, forKey: .collectedIssues)
//        dates = try values.decodeIfPresent([Dates].self, forKey: .dates)
//        prices = try values.decodeIfPresent([Prices].self, forKey: .prices)
//        thumbnail = try values.decodeIfPresent(Thumbnail.self, forKey: .thumbnail)
//        images = try values.decodeIfPresent([Images].self, forKey: .images)
//        creators = try values.decodeIfPresent(Creators.self, forKey: .creators)
//        characters = try values.decodeIfPresent(Characters.self, forKey: .characters)
//        stories = try values.decodeIfPresent(Stories.self, forKey: .stories)
//        events = try values.decodeIfPresent(Events.self, forKey: .events)
//    }
//}
//struct TextObjects : Codable {
//    let type : String?
//    let language : String?
//    let text : String?
//    
//    enum CodingKeys: String, CodingKey {
//        
//        case type = "type"
//        case language = "language"
//        case text = "text"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        type = try values.decodeIfPresent(String.self, forKey: .type)
//        language = try values.decodeIfPresent(String.self, forKey: .language)
//        text = try values.decodeIfPresent(String.self, forKey: .text)
//    }
//}
//
//struct Urls : Codable {
//    let type : String?
//    let url : String?
//    
//    enum CodingKeys: String, CodingKey {
//        
//        case type = "type"
//        case url = "url"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        type = try values.decodeIfPresent(String.self, forKey: .type)
//        url = try values.decodeIfPresent(String.self, forKey: .url)
//    }
//}
//struct Series : Codable {
//    let resourceURI : String?
//    let name : String?
//    
//    enum CodingKeys: String, CodingKey {
//        
//        case resourceURI = "resourceURI"
//        case name = "name"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        resourceURI = try values.decodeIfPresent(String.self, forKey: .resourceURI)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//    }
//}
//struct Variants : Codable {
//    let resourceURI : String?
//    let name : String?
//    
//    enum CodingKeys: String, CodingKey {
//        
//        case resourceURI = "resourceURI"
//        case name = "name"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        resourceURI = try values.decodeIfPresent(String.self, forKey: .resourceURI)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//    }
//    
//}
//struct Dates : Codable {
//    let type : String?
//    let date : String?
//    
//    enum CodingKeys: String, CodingKey {
//        
//        case type = "type"
//        case date = "date"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        type = try values.decodeIfPresent(String.self, forKey: .type)
//        date = try values.decodeIfPresent(String.self, forKey: .date)
//    }
//}
//struct Prices : Codable {
//    let type : String?
//    let price : Double?
//    
//    enum CodingKeys: String, CodingKey {
//        
//        case type = "type"
//        case price = "price"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        type = try values.decodeIfPresent(String.self, forKey: .type)
//        price = try values.decodeIfPresent(Double.self, forKey: .price)
//    }
//}
//struct Thumbnail : Codable {
//    let path : String?
//    let ext : String?
//    
//    enum CodingKeys: String, CodingKey {
//        
//        case path = "path"
//        case ext = "extension"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        path = try values.decodeIfPresent(String.self, forKey: .path)
//        ext = try values.decodeIfPresent(String.self, forKey: .ext)
//    }
//}
//struct Images : Codable {
//    let path : String?
//    let ext : String?
//    
//    enum CodingKeys: String, CodingKey {
//        
//        case path = "path"
//        case ext = "extension"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        path = try values.decodeIfPresent(String.self, forKey: .path)
//        ext = try values.decodeIfPresent(String.self, forKey: .ext)
//    }
//}
//
//struct Creators : Codable {
//    let available : Int?
//    let collectionURI : String?
//    let items : [Items]?
//    let returned : Int?
//    
//    enum CodingKeys: String, CodingKey {
//        
//        case available = "available"
//        case collectionURI = "collectionURI"
//        case items = "items"
//        case returned = "returned"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        available = try values.decodeIfPresent(Int.self, forKey: .available)
//        collectionURI = try values.decodeIfPresent(String.self, forKey: .collectionURI)
//        items = try values.decodeIfPresent([Items].self, forKey: .items)
//        returned = try values.decodeIfPresent(Int.self, forKey: .returned)
//    }
//}
//struct Items : Codable {
//    let resourceURI : String?
//    let name : String?
//    let type : String?
//    
//    enum CodingKeys: String, CodingKey {
//        
//        case resourceURI = "resourceURI"
//        case name = "name"
//        case type = "type"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        resourceURI = try values.decodeIfPresent(String.self, forKey: .resourceURI)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        type = try values.decodeIfPresent(String.self, forKey: .type)
//    }
//}
//struct Characters : Codable {
//    let available : Int?
//    let collectionURI : String?
//    let items : [Items]?
//    let returned : Int?
//    
//    enum CodingKeys: String, CodingKey {
//        
//        case available = "available"
//        case collectionURI = "collectionURI"
//        case items = "items"
//        case returned = "returned"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        available = try values.decodeIfPresent(Int.self, forKey: .available)
//        collectionURI = try values.decodeIfPresent(String.self, forKey: .collectionURI)
//        items = try values.decodeIfPresent([Items].self, forKey: .items)
//        returned = try values.decodeIfPresent(Int.self, forKey: .returned)
//    }
//}
//
//struct Stories : Codable {
//    let available : Int?
//    let collectionURI : String?
//    let items : [Items]?
//    let returned : Int?
//    
//    enum CodingKeys: String, CodingKey {
//        
//        case available = "available"
//        case collectionURI = "collectionURI"
//        case items = "items"
//        case returned = "returned"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        available = try values.decodeIfPresent(Int.self, forKey: .available)
//        collectionURI = try values.decodeIfPresent(String.self, forKey: .collectionURI)
//        items = try values.decodeIfPresent([Items].self, forKey: .items)
//        returned = try values.decodeIfPresent(Int.self, forKey: .returned)
//    }
//    
//}
//struct Events : Codable {
//    let available : Int?
//    let collectionURI : String?
//    let items : [Items]?
//    let returned : Int?
//    
//    enum CodingKeys: String, CodingKey {
//        
//        case available = "available"
//        case collectionURI = "collectionURI"
//        case items = "items"
//        case returned = "returned"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        available = try values.decodeIfPresent(Int.self, forKey: .available)
//        collectionURI = try values.decodeIfPresent(String.self, forKey: .collectionURI)
//        items = try values.decodeIfPresent([Items].self, forKey: .items)
//        returned = try values.decodeIfPresent(Int.self, forKey: .returned)
//    }
//    
//}
