//
//  EmotionsViewController.swift
//  02FaceIt
//
//  Created by Julio Franco on 6/26/16.
//  Copyright © 2016 Julio Franco. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {

    private let emotionalFaces: [String: FacialExpression] = [
        "angry":  FacialExpression(eyes: .Closed, eyeBrows: .Furrowed, mouth: .Frown),
        "happy": FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smile),
        "worried": FacialExpression(eyes: .Open, eyeBrows: .Relaxed, mouth: .Smirk),
        "mischievious": FacialExpression(eyes: .Open, eyeBrows: .Furrowed, mouth: .Grin)
    ]
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let faceVC = segue.destinationViewController as? FaceViewController {
            if let expression = emotionalFaces[segue.identifier!] {
                faceVC.expression = expression
                faceVC.navigationItem.title = sender?.currentTitle
            }
        }
    }

    // For logging ViewControllerCycle to console
    let instance = getEmotionsMVCinstanceCount()

}
