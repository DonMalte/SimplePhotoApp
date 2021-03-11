//
//  PhotoCell.swift
//  SimplePhotoApp
//
//  Created by Malte Schoppe on 24.02.21.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    //MARK:- IBOutlets
    @IBOutlet weak var photoCellImageView: UIImageView!
    
    //MARK:- Variables
    ///Set the photo for it to be displayed in the cell
    var photo: Photo? {
        didSet {
            if let photo = photo {
                if let url = URL(string: photo.url) {
                    photoCellImageView.sd_setImage(with: url, placeholderImage: placeholderImage, options: [], context: nil)
                } else {
                    setPlaceholderImage()
                }
            } else {
                setPlaceholderImage()
            }
        }
    }
    
    private let placeholderImage = UIImage(named: "placeholder")
    
    //MARK:- Set Placeholder Image
    private func setPlaceholderImage() {
        photoCellImageView.image = placeholderImage
    }
    
    //MARK:- Cell Lifecycle
    override func prepareForReuse() {
        photoCellImageView.image = nil
    }
}
