//
//  Photo.swift
//  SimplePhotoApp
//
//  Created by Malte Schoppe on 24.02.21.
//

import Foundation

struct Photo: Decodable {
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
}
