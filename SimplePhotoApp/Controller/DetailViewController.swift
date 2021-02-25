//
//  DetailViewController.swift
//  SimplePhotoApp
//
//  Created by Malte Schoppe on 24.02.21.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var detailViewTitleLabel: UILabel!
    @IBOutlet weak var detailViewImageView: UIImageView!
    
    //MARK:- Variables
    var photo: Photo?
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        showPhoto()
    }
    
    //MARK:- Photo functions
    //Show photo and title of the photo object
    private func showPhoto() {
        guard let photo = photo else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        if let url = URL(string: photo.url) {
            detailViewImageView.sd_setImage(with: url, completed: nil)
        }
        detailViewTitleLabel.text = photo.title
    }

}
