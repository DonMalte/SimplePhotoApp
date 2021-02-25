//
//  AlbumCollectionViewHeader.swift
//  SimplePhotoApp
//
//  Created by Malte Schoppe on 25.02.21.
//

import UIKit

class PhotoCollectionViewHeader: UICollectionReusableView {
    
    //MARK: IBOutlets
    @IBOutlet weak var headerLabel: UILabel!
    
    //MARK: Variables
    var albumTitle: String? {
        didSet {
            if let title = albumTitle {
                headerLabel.text = title
            }
        }
    }
    
}
