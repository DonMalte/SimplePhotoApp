//
//  AlbumCellDelegate.swift
//  SimplePhotoApp
//
//  Created by Malte Schoppe on 11.03.21.
//

import Foundation

protocol AlbumCellDelegate {
    ///Show an error alert when the network request fails
    func networkRequestFailed()
}
