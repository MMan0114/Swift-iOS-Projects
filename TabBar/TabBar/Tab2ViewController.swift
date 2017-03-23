//  Converted with Swiftify v1.0.6285 - https://objectivec2swift.com/
//
//  Tab2ViewController.swift
//  TabBar
//
//  Created by MMan on 9/21/16.
//  Copyright © 2016 MananKothari. All rights reserved.
//
import UIKit
class Tab2ViewController: UIViewController {

    @IBOutlet var imageView2: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Initalize Image to Display
        imageView2?.image = UIImage(named: ("music_Oddisee.jpg"))
        imageView2?.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
