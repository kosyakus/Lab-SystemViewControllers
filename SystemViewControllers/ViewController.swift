//
//  ViewController.swift
//  SystemViewControllers
//
//  Created by Admin on 12.10.17.
//  Copyright © 2017 NS. All rights reserved.
//

import UIKit
import SafariServices // to display web content

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func shareButtonTapped(_ sender: UIButton) {
        
        guard let image = imageView.image else {return}
        // add sharing to another app using ActivityVC
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender
        
        present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func safariButtonTapped(_ sender: UIButton) {
        // create url from string, create instance of SFS and present SafariVC
        if let url = URL(string: "http://apple.com") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated:  true, completion: nil)
        }
        
    }
    
    // to access the user's camera or photo library two protocols must be adopted: UIImagePickerControllerDelegate and UINavigationControllerDelegate
    // also in Info.plist enter a new key for NSPhotoLibraryUsageDescription (Privacy - Photo Library Usage), for value enter smth like "To share photos from the camera or photo library"
    @IBAction func photoButtonTapped(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController() // instance
        imagePicker.delegate = self // set this VC as delegate
        
        // ask the user if they want to take a new photo or select an existing photo from library
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        
        /*let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
            print("User selected Camera action")
        })*/
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "photo library", style: .default, handler: { action in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        /*let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { action in
            print("User selected Photo Library action")
        })*/
        
        alertController.popoverPresentationController?.sourceView = sender
        
        present(alertController, animated: true, completion: nil)
        
    }
    // func for returning the selected photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = selectedImage
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func emailButtonTapped(_ sender: Any) {
    }
    
}

