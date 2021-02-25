//
//  PhotoCollectionViewController.swift
//  SimplePhotoApp
//
//  Created by Malte Schoppe on 24.02.21.
//

import UIKit

private let photoCellReuseIdentifier = "photoCell"
private let headerReuseIdentifier = "photoCollectionViewHeader"
private let toDetailViewSegueIdentifier = "toDetailViewSegue"

class PhotoCollectionViewController: UICollectionViewController {

    //MARK:- Class Properties
    var photos = [Photo]()
    
    //Show the album title in the collectionView header
    var albumTitle: String?
    
    /// The photoZoomValue is equivalent to the numbers of images that are displayed in a row
    private var photoZoomValue: CGFloat = 2
    
    private var pinchRecognizer: UIPinchGestureRecognizer?
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //The title of the navigationItem is set in the prepare(for segue) function in the previous AlbumCollectionViewController
        
        //Add UIStepper for photo size control
        addStepperToView()
        
        //Add pinchGestureRecognizer to change the photo size with a natural motion
        pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinchRecognized(sender:)))
        self.view.addGestureRecognizer(pinchRecognizer!)
    }
    
    // MARK:- UIStepper
    
    @objc private func pinchRecognized(sender: UIPinchGestureRecognizer) {
        
        //If the recognizer.isEnabled state isn't checked before the sizeStepper is changed, the zoom would in-/decrease twofold
        
        if sender.scale >= 1.5 {
        
            if let recognizer = pinchRecognizer, recognizer.isEnabled {
                changeSizeStepperAndLayout(increase: true)
            }
        } else if sender.scale <= 0.8 {
            
            if let recognizer = pinchRecognizer, recognizer.isEnabled {
                changeSizeStepperAndLayout(increase: false)
            }
        }
    }
    
    private func changeSizeStepperAndLayout(increase: Bool) {
        if let recognizer = pinchRecognizer {
            recognizer.isEnabled = false
        }

        if increase {
            sizeStepper.value = sizeStepper.value+1
        } else {
            sizeStepper.value = sizeStepper.value-1
        }
        
        //inform the view that the size of the photos should change
        sizeStepperValueChanged(sender: sizeStepper)
    }
    
    
    @objc func sizeStepperValueChanged(sender: UIStepper) {

        // revert the value of the stepper, otherwise it would feel less intuitive when somebody taps plus and the images get smaller
        switch sender.value {
        case 1:
            photoZoomValue = 4
        case 2:
            photoZoomValue = 3
        case 3:
            photoZoomValue = 2
        case 4:
            photoZoomValue = 1
        default:
            photoZoomValue = 2
        }
        
        // inform the collectionView to update the size of its cells
        collectionView.performBatchUpdates(nil) { (_) in
            if let recognizer = self.pinchRecognizer {
                
                // enable the recognizer again for the next pinch
                recognizer.isEnabled = true
            }
        }
    }
    
    ///Add UIStepper to change the size of the displayed photos
    private func addStepperToView() {
        
        self.view.addSubview(sizeStepper)
        NSLayoutConstraint.activate([
            sizeStepper.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            sizeStepper.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30)
        ])
    }
    
    // MARK:- Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Move to DetailViewController and pass on the selected photo
        if segue.identifier == toDetailViewSegueIdentifier {
            if let photo = sender as? Photo, let detailVC = segue.destination as? DetailViewController {
                detailVC.photo = photo
            }
        }
    }

    // MARK:- UICollectionViewDataSource

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
    
    
    //MARK: CollectionView Header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath) as? PhotoCollectionViewHeader {
            
            if let title = albumTitle {
                header.albumTitle = title
            }
            
            return header
        } else {
            preconditionFailure("Couldn't dequeue the PhotoCollectionHeaderView")
        }
    }

    // MARK:- UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.item]
        
        performSegue(withIdentifier: toDetailViewSegueIdentifier, sender: photo)
    }
    
    // MARK:- UI Initialization
    
    let sizeStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.minimumValue = 1
        stepper.maximumValue = 4
        stepper.value = 3
        stepper.addTarget(self, action: #selector(sizeStepperValueChanged(sender:)), for: .valueChanged)
        
        return stepper
    }()
}

//MARK:- Extension

extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    //MARK:- UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //The default view is a photo that is half the screens width, with a spacing of 1 between cells and lines
        //The images are always square
        
        let spacing = photoZoomValue-1
        
        let width = (collectionView.frame.width-spacing)/photoZoomValue
        let size = CGSize(width: width, height: width)
        
        return size
    }
    
    //MARK: CollectionView Header Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let indexPath = IndexPath(row: 0, section: section)
        let header = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        
        let targetSize = CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height)
        
        //Calculate the optimal height, as there isn't an easy way like UITableView.automaticDimension
        let size = header.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)

        return size
    }
}
