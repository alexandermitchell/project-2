//
//  Article.swift
//  Project-2-Mitchell
//
//  Created by Alex Mitchell on 2016-12-07.
//  Copyright © 2016 Alex Mitchell. All rights reserved.
//

import Foundation

class Article {
    
    var author: String
    var title: String
    var description: String
    var urlToArticle: String
    var urlToImage: String
    var publishedAt: String
    
    
    init(jsonObject: [String:Any]) {
        
        let author = jsonObject["author"] as? String ?? "unknown"
        let title = jsonObject["title"] as? String ?? "unknown"
        let description = jsonObject["description"] as? String ?? "unknown"
        let urlToArticle = jsonObject["url"] as? String ?? "unknown"
        let urlToImage = jsonObject["urlToImage"] as? String ?? "unknown"
        let publishedAt = jsonObject["publishedAt"] as? String ?? "unknown"
        
        self.author = author
        self.title = title
        self.description = description
        self.urlToArticle = urlToArticle
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
    }
    
}
