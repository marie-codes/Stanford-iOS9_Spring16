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
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    private func fetchImage() {
        if let url = imageURL {
            spinner?.startAnimating()
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
                let contentsOfURL = NSData(contentsOfURL: url)
                dispatch_async(dispatch_get_main_queue()) {
                    if url == self.imageURL {
                        if let imageData = contentsOfURL {
                            self.image = UIImage(data: imageData)
                        }
                    } else {
                        print("ignored data returned from url \(url)")
                    }
                }
            }
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.frame.size
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.25
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
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
            
            spinner?.stopAnimating()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        if image == nil {
            fetchImage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
    }


}

extension ImageViewController: UIScrollViewDelegate {
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}


