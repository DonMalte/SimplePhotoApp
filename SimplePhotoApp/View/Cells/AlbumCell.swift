//
//  AlbumCell.swift
//  SimplePhotoApp
//
//  Created by Malte Schoppe on 24.02.21.
//

import UIKit

class AlbumCell: UICollectionViewCell {
    
    @IBOutlet weak var albumCellImageView: UIImageView!
    @IBOutlet weak var albumCellTitleLabel: UILabel!
    
    var album: Album? {
        didSet {
            if let album = album {
                albumCellTitleLabel.text = album.title
            }
        }
    }
    
    override func awakeFromNib() {
        albumCellImageView.layer.cornerRadius = 8
    }
}
