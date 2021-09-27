//
//  MoviesModel.swift
//  Nerdflix
//
//  Created by Natália Carolina Dos Santos on 26/09/21.
//

import Foundation

struct MoviesModel: Codable {
    
    let items: [ MovieItemModel ]?
    
}

struct MovieItemModel: Codable {
    let fullTitle: String?
    let image: String?
    let id: String?
}
