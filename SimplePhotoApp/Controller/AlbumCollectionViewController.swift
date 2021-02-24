//
//  AlbumCollectionViewController.swift
//  SimplePhotoApp
//
//  Created by Malte Schoppe on 23.02.21.
//

import UIKit

private let albumCellReuseIdentifier = "albumCell"

class AlbumCollectionViewController: UICollectionViewController {
    
    var albums = [Album]()
    
    let collectionViewSpacing: CGFloat = 20

    override func viewDidLoad() {
        super.viewDidLoad()

        
        fetchAlbums()
    }
    
    func setUpViewController() {
        
    }

    func fetchAlbums() {
        Network.getAlbumData { (albums, err) in
            if let error = err {
                print("We have an error: \(error)")
            } else {
                if let albums = albums {
                    self.albums = albums
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return albums.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: albumCellReuseIdentifier, for: indexPath) as? AlbumCell {
            
            let album = albums[indexPath.row]
            
            cell.album = album
            
            return cell
        }
    
        return UICollectionViewCell()
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension AlbumCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width/2)-(collectionViewSpacing*1.5)
        let height = (collectionView.frame.width/2)+30
        let size = CGSize(width: width, height: height)
        
        return size
    }
}

