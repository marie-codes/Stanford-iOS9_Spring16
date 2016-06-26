//
//  ImageViewController.swift
//  03Cassini
//
//  Created by Julio Franco on 6/26/16.
//  Copyright © 2016 Julio Franco. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    var imageURL: NSURL? {
        didSet {
            image = nil // Clear out whatever image might have been showing
            fetchImage()
        }
    }
    
    private func fetchImage() {
        if let url = imageURL {
            if let imageData = NSData(contentsOfURL: url) {
                image = UIImage(data: imageData)
            }
        }
    }
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.frame.size
        }
    }
    
    private var imageView = UIImageView() // frame: x:0 y: 0, width: 0, height: 0
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            
            // This is optional so the line won't run incase the scrollView has not been instantiated
            // Later we will segue into this ImageVC and set the image, thus the scrollView will not be
            // instatiated yet
            scrollView?.contentSize = imageView.frame.size
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
        imageURL = NSURL(string: DemoURL.Stanford)
    }


}


