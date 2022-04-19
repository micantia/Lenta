//
//  ImageCacheStorage.swift
//  Lenta
//
//  Created by Alexandr Nesterenko on 19.04.22.
//

import Foundation
import UIKit

final class ImageCacheStorage {
    
    static let shared = ImageCacheStorage()
    
    private init() {}
    
    private let lock = NSLock()
    private var cache = [URL: UIImage]()
    
    func addToCache(_ image: UIImage?, for url: URL) {
        defer { lock.unlock() }
        lock.lock()
        cache[url] = image
    }
    
    func getImage(for url: URL) -> UIImage? {
        defer { lock.unlock() }
        lock.lock()
        return cache[url]
    }
}

