//
//  NewsItem.swift
//  Lenta
//
//  Created by Alexandr Nesterenko on 19.04.22.
//

import Foundation
import UIKit

struct NewsItem {
    
    let title: String
    let subtitle: String
    let imageUrl: String?
    
}

extension NewsItem: Hashable, Codable {}
