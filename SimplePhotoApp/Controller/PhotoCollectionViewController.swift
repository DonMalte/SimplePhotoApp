//
//  PhotoCollectionViewController.swift
//  SimplePhotoApp
//
//  Created by Malte Schoppe on 24.02.21.
//

import UIKit

private let photoCellReuseIdentifier = "photoCell"
private let toDetailViewSegueIdentifier = "toDetailViewSegue"

class PhotoCollectionViewController: UICollectionViewController {

    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //The title of the navigationItem is set in the prepare(for segue) function in the previous AlbumCollectionViewController
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Move to DetailViewController and pass on the selected photo
        if segue.identifier == toDetailViewSegueIdentifier {
            if let photo = sender as? Photo, let detailVC = segue.destination as? DetailViewController {
                detailVC.photo = photo
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellReuseIdentifier, for: indexPath) as? PhotoCell {
            let photo = photos[indexPath.item]
            
            cell.photo = photo
            
            return cell
        }
        
        return UICollectionViewCell()
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.item]
        
        performSegue(withIdentifier: toDetailViewSegueIdentifier, sender: photo)
    }
    
}

extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    //MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //The default view is a photo that is half the screens width, with a spacing of 1 between cells and lines
        let halfScreenWidth = collectionView.frame.width/2-1
        let size = CGSize(width: halfScreenWidth, height: halfScreenWidth)
        
        return size
    }
}
