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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitViewController?.delegate = self
    }
    
}

extension CassiniViewController: UISplitViewControllerDelegate {
    
    // Since we are using a SplitViewController
    // Notice how before we have this, it automatically starts on a blank ImageVC
    // and then we need to go back to the 'Menu'
    // By doing the following it will start on the 'Menu'
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
        if primaryViewController.contentViewController == self {
            if let ivc = secondaryViewController as? ImageViewController where ivc.imageURL == nil {
                return true
            }
        }
        return false
    }
}

extension UIViewController {
    // This property is used above to get the VC 'inside' the NavigationController
    // since we embedded the CassiniVC in a navigationController.
    // Because the primary/master VC of the SplitViewController is actully the NavigationController
    var contentViewController: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}


