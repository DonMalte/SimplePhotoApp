//
//  PhotoCell.swift
//  SimplePhotoApp
//
//  Created by Malte Schoppe on 24.02.21.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoCellImageView: UIImageView!
    
    ///Set the photo for it to be displayed in the cell
    var photo: Photo? {
        didSet {
            if let photo = photo {
                if let url = URL(string: photo.url) {
                    photoCellImageView.sd_setImage(with: url, completed: nil)
                }
            }
        }
    }
    
    override func prepareForReuse() {
        photoCellImageView.image = nil
    }
}
