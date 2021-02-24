//
//  Album.swift
//  SimplePhotoApp
//
//  Created by Malte Schoppe on 23.02.21.
//

import Foundation

struct Album: Decodable {
    var userId: Int
    var id: Int
    var title: String
}
