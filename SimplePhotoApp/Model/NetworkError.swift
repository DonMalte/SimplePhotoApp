//
//  NetworkError.swift
//  SimplePhotoApp
//
//  Created by Malte Schoppe on 23.02.21.
//

import Foundation

enum NetworkError {
    ///Unknown network error
    case unknown
    ///Error while requesting the data, maybe the server is not responding or the request got a syntax error
    case requestError
    //Error while formating the data to the desired object
    case fetchError
}
