//
//  UIImageView+download.swift
//  Lenta
//
//  Created by Alexandr Nesterenko on 19.04.22.
//

import Foundation
import UIKit
import Alamofire

extension UIImageView {
    
    func download(at stringUrl: String?) {
        
        guard let url = stringUrl.flatMap({ URL(string: $0) }) else { return }
        
        DispatchQueue.global(qos: .background).async {
            let imageCache = ImageCacheStorage.shared
            if let cachedImage = imageCache.getImage(for: url) {
                DispatchQueue.main.async { [weak self] in
                    self?.image = cachedImage
                }
                return
            }
            
            AF.request(url)
                .response { response in
                    if let data = response.data {
                        let image = UIImage(data: data)
                        imageCache.addToCache(image, for: url)
                        DispatchQueue.main.async { [weak self] in
                            self?.image = image
                        }
                    }
                }
        }
        
    }
    
}
