//  Converted with Swiftify v1.0.6285 - https://objectivec2swift.com/
//
//  ViewController.swift
//  gesture
//
//  Created by MMan on 10/26/16.
//  Copyright © 2016 MananKothari. All rights reserved.
//
import UIKit
class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!

    var lastScaleFactor: CGFloat = 1
    var images = [Any]()
    var imageIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            //recognize tap
            //    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
            //    tapGesture.numberOfTapsRequired = 2;
            //    [imageView addGestureRecognizer:tapGesture];
            //add a pinch Gesture
        var pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.handlePinchGesture))
        imageView?.addGestureRecognizer(pinchGesture)
        //swipe gesture
        images = ["imageOne.jpg", "imageTwo.jpg", "imageThree.gif" + 
            "imageFour.jpg", "imageFive.jpg"]
            //right swipe which is default
        var swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipeGesture))
        imageView?.addGestureRecognizer(swipeGesture)
            //now add left swipe
        var leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipeGesture))
        leftSwipeGesture.direction = .left
        imageView?.addGestureRecognizer(leftSwipeGesture)
    }

    @IBAction func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        var direction: UISwipeGestureRecognizerDirection? = (sender as? UISwipeGestureRecognizer)?.direction
        switch direction {
            case UISwipeGestureRecognizerDirection.?left:
                print("Swipe Direction Left")
                imageIndex -= 1
            case UISwipeGestureRecognizerDirection.?right:
                print("Swipe Direction Right")
                imageIndex += 1
            default:
                break
        }

        imageIndex = (imageIndex < 0) ? (images.count - 1) : imageIndex % images.count
        imageView?.image = UIImage(named: images[imageIndex] as! String)
    }

    @IBAction func handlePinchGesture(_ sender: UIPinchGestureRecognizer) {
        var factor: CGFloat? = (sender as? UIPinchGestureRecognizer)?.scale
        print("Pinched factor \(factor)")
        if factor! > CGFloat(1) {
            //zoom in
            sender.view?.transform = CGAffineTransform(scaleX: lastScaleFactor + (factor! - 1), y: lastScaleFactor + (factor! - 1))
        }
        else {
            //zoom out
            sender.view?.transform = CGAffineTransform(scaleX: lastScaleFactor * factor!, y: factor!)
        }
        if sender.state == .ended {
            if factor! > CGFloat(1) {
                lastScaleFactor += (factor! - 1)
            }
            else {
                lastScaleFactor *= factor!
            }
        }
    }

    @IBAction func handleTapGesture(_ sender: UITapGestureRecognizer) {
        print("Tap Tap")
        if sender.view?.contentMode == .scaleAspectFill {
            sender.view?.contentMode = .center
        }
        else {
            sender.view?.contentMode = .scaleAspectFill
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
