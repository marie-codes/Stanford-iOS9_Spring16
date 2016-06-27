//
//  CassiniViewController.swift
//  03Cassini
//
//  Created by Julio Franco on 6/26/16.
//  Copyright © 2016 Julio Franco. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {

    private struct Storyboard {
        static let ShowImageSegue = "Show Image"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Storyboard.ShowImageSegue {
            if let vc = segue.destinationViewController as? ImageViewController {
                let imageName = (sender as? UIButton)?.currentTitle
                vc.imageURL = DemoURL.NASAImageNames(imageName)
                vc.title = imageName
            }
        }
    }
    

}
