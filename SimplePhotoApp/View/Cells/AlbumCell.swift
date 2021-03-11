//
//  AlbumCell.swift
//  SimplePhotoApp
//
//  Created by Malte Schoppe on 24.02.21.
//

import UIKit
import SDWebImage

class AlbumCell: UICollectionViewCell {
    
    //MARK:- IBOutlets
    @IBOutlet weak var albumCellImageView: UIImageView!
    @IBOutlet weak var albumCellTitleLabel: UILabel!
    
    //MARK:- Variables
    var album: Album? {
        didSet {
            if let album = album {
                albumCellTitleLabel.text = album.title
                
                if let photos = album.photos {
                    setThumbnailPhoto(photos: photos)
                } else {
                    getPhotosForAlbum(albumId: album.id)
                }
            }
        }
    }
    
    //MARK:- Photo functions
    ///set the thumnail picture from the first photo of the current album
    private func setThumbnailPhoto(photos: [Photo]) {
        if let photo = photos.first {
            if let url = URL(string: photo.thumbnailUrl) {
                self.albumCellImageView.sd_setImage(with: url, completed: nil)
            }
        }
    }
    
    /// Fetch the photos for the specified id to set the thumbnail image and for further selection later on
    private func getPhotosForAlbum(albumId: Int) {
        Network.getPhotosForAlbum(albumId: albumId) { (photos, err) in
            if let error = err {
                print("We have an error: \(error)")
            } else if let photos = photos {
                self.album?.photos = photos
                self.setThumbnailPhoto(photos: photos)
            }
        }
    }
    
    //MARK:- Cell lifecycle
    override func awakeFromNib() {
        albumCellImageView.layer.cornerRadius = 8
    }
    
    override func prepareForReuse() {
        albumCellImageView.image = nil
    }
}
