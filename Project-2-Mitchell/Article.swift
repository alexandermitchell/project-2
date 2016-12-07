//
//  Article.swift
//  Project-2-Mitchell
//
//  Created by Alex Mitchell on 2016-12-07.
//  Copyright © 2016 Alex Mitchell. All rights reserved.
//

import Foundation


//"author": null,
//"title": "Does winter meetings splash make Red Sox better than Cubs?",
//"description": "With the Red Sox making their World Series-or-bust intentions clear for 2017, here's a way-too-early look at how they match up with the champs.",
//"url": "http://espn.com/blog/sweetspot/post/_/id/76865",
//"urlToImage": "http://a4.espncdn.com/combiner/i?img=%2Fphoto%2F2016%2F1207%2Fmlb_salelester_ms_1296x729.jpg",
//"publishedAt": "2016-12-07T19:33:46Z"

class Article {
    
    var author: String
    var title: String
    var description: String
    var urlToArticle: String
    var urlToImage: String
    
    init(author: String, title: String, description: String, urlToArticle: String, urlToImage: String) {
        
        self.author = author
        self.title = title
        self.description = description
        self.urlToArticle = urlToArticle
        self.urlToImage = urlToImage
        
    }
    
    
}
