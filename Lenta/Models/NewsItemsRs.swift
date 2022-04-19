//
//  NewsItemsRs.swift
//  Lenta
//
//  Created by Alexandr Nesterenko on 19.04.22.
//

import Foundation

struct NewsItemsRs: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [NewsItem]?
}
