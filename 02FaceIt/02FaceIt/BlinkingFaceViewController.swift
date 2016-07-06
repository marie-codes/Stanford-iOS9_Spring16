//
//  BlinkingFaceViewController.swift
//  02FaceIt
//
//  Created by Julio Franco on 7/5/16.
//  Copyright © 2016 Julio Franco. All rights reserved.
//

import UIKit

class BlinkingFaceViewController: FaceViewController {

    var blinking: Bool = false {
        didSet {
            startBlink()
        }
    }
    
    private struct BlinkRate {
        static let ClosedDuration = 0.4
        static let OpenDuration = 2.5
    }
    
    func startBlink() {
        if blinking {
            faceView.eyesOpen = false
            NSTimer.scheduledTimerWithTimeInterval(
                BlinkRate.ClosedDuration,
                target: self, selector: #selector(BlinkingFaceViewController.endBlink),
                userInfo: nil,
                repeats: false)
        }
    }
    
    func endBlink() {
        faceView.eyesOpen = true
        NSTimer.scheduledTimerWithTimeInterval(
            BlinkRate.OpenDuration,
            target: self, selector: #selector(BlinkingFaceViewController.startBlink),
            userInfo: nil,
            repeats: false)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        blinking = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        blinking = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
