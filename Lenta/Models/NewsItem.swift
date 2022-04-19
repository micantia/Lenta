//
//  NewsItem.swift
//  Lenta
//
//  Created by Alexandr Nesterenko on 19.04.22.
//

import Foundation
import UIKit

struct NewsItem {
    
    let source: NewsItemSource?
    let title: String?
    let description: String?
    let urlToImage: String?
    let url: String?
    let content: String?
    let publishedAt: String?
    
}

extension NewsItem: Hashable, Codable {}

struct NewsItemSource {
    let id: String?
    let name: String?
}

extension NewsItemSource: Hashable, Codable {}
