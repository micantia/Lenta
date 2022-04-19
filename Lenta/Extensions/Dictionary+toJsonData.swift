//
//  Dictionary+toJsonData.swift
//  Lenta
//
//  Created by Alexandr Nesterenko on 19.04.22.
//

import Foundation

extension Dictionary {
    func toJsonData() throws -> Data {
        return try JSONSerialization.data(withJSONObject: self)
    }
}
