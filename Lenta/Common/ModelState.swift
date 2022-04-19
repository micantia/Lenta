//
//  ModelState.swift
//  Lenta
//
//  Created by Alexandr Nesterenko on 19.04.22.
//

import Foundation

enum ModelState<Model> {
    
    case loading
    case loaded(Model)
    case error(Error)
    
}

enum ModelStateError: Error {
    case StatusError
}
