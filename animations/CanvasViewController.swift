//
//  CanvasViewController.swift
//  animations
//
//  Created by Kelly Lampotang on 6/30/16.
//  Copyright © 2016 Kelly Lampotang. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    
    @IBOutlet weak var trayView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        trayDownOffset = 165
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x, y: trayView.center.y + trayDownOffset)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didPanTray(sender: AnyObject) {
        let translation = sender.translationInView(view)
        if sender.state == .Began {
            trayOriginalCenter = trayView.center
        } else if sender.state == .Changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        } else if sender.state == .Ended {
            var velocity = sender.velocityInView(view)
            if (velocity.y > 0) {
                UIView.animateWithDuration(0.5) {
                    self.trayView.center = self.trayDown
                }
            } else if (velocity.y < 0) {
                UIView.animateWithDuration(0.5) {
                    self.trayView.center = self.trayUp
                }
            }
        }
    }
    
    func didPanFaceCanvas(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        if sender.state == .Began {
            newlyCreatedFace = sender.view as! UIImageView
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            UIView.animateWithDuration(0.5, animations: {
                self.newlyCreatedFace.transform = CGAffineTransformMakeScale(1.5, 1.5)
            })
        } else if sender.state == .Changed {
            UIView.animateWithDuration(0.1, animations: {
                self.newlyCreatedFace.center = CGPoint(x: self.newlyCreatedFaceOriginalCenter.x + translation.x, y: self.newlyCreatedFaceOriginalCenter.y + translation.y)
            })
        } else if sender.state == .Ended {
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations:
                {
                    self.newlyCreatedFace.transform = CGAffineTransformMakeScale(0.67, 0.67)
                }, completion: nil)

        }
    }
    func didPinchFaceCanvas(sender: UIPinchGestureRecognizer)
    {
        let scale = sender.scale
        let originalStateSize = newlyCreatedFace.transform
        if sender.state == .Began
        {
            
        }
        if sender.state == .Changed
        {
            UIView.animateWithDuration(0.5) {
                self.newlyCreatedFace.transform = CGAffineTransformScale(originalStateSize, scale, scale)
            }
        }
    }
    
    @IBAction func didPanFace(sender: AnyObject) {
        let translation = sender.translationInView(view)
        if sender.state == .Began {
            let imageView = sender.view! as! UIImageView //references the face we clicked on
            newlyCreatedFace = UIImageView(image: imageView.image)
            
            // Add gesture recognizer :
            var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "didPanFaceCanvas:")
            //Add another gesture recognizer: 
            var pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: "didPinchFaceCanvas:")
            newlyCreatedFace.addGestureRecognizer(pinchGestureRecognizer)
            newlyCreatedFace.userInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
            
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            UIView.animateWithDuration(0.5, animations: { 
                self.newlyCreatedFace.transform = CGAffineTransformMakeScale(1.5, 1.5)
            })
            
        } else if sender.state == .Changed {
            UIView.animateWithDuration(0.1, animations: {
                self.newlyCreatedFace.center = CGPoint(x: self.newlyCreatedFaceOriginalCenter.x + translation.x, y: self.newlyCreatedFaceOriginalCenter.y + translation.y)
            })
            
        } else if sender.state == .Ended{
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations:
                {
                    self.newlyCreatedFace.transform = CGAffineTransformMakeScale(0.67, 0.67)
                }, completion: nil)
        }
    
    }
    

}
