//
//  AlbumCollectionViewController.swift
//  SimplePhotoApp
//
//  Created by Malte Schoppe on 23.02.21.
//

import UIKit

private let albumCellReuseIdentifier = "albumCell"
private let photoSegueIdentifier = "toPhotoViewSegue"

class AlbumCollectionViewController: UICollectionViewController {
    
    //MARK:- Variables
    private var albums = [Album]()
    
    private let collectionViewSpacing: CGFloat = 20

    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
        fetchAlbums()
    }
    

    private func fetchAlbums() {
        Network.getAlbumData { (albums, err) in
            if let error = err {
                print("We have an error: \(error)")
            } else {
                if let albums = albums {
                    self.albums = albums
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == photoSegueIdentifier {
            if let album = sender as? Album {
                if let photoVC = segue.destination as? PhotoCollectionViewController {
                    if let photos = album.photos {
                        photoVC.photos = photos
                        photoVC.albumTitle = album.title
                    }
                }
            }
        }
    }
    

    // MARK:- UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return albums.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: albumCellReuseIdentifier, for: indexPath) as? AlbumCell {
            
            let album = albums[indexPath.item]
            
            cell.album = album
            
            return cell
        }
    
        return UICollectionViewCell()
    }

    // MARK:- UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let album = albums[indexPath.item]
        
        performSegue(withIdentifier: photoSegueIdentifier, sender: album)
    }

}

// MARK:- Extensions
extension AlbumCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK:- UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width/2)-(collectionViewSpacing*1.5)
        let height = (collectionView.frame.width/2)+30
        let size = CGSize(width: width, height: height)
        
        return size
    }
}

