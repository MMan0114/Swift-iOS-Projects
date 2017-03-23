//  Converted with Swiftify v1.0.6285 - https://objectivec2swift.com/
//
//  Tab3ViewController.swift
//  TabBar
//
//  Created by MMan on 10/18/16.
//  Copyright © 2016 MananKothari. All rights reserved.
//
import UIKit
class Tab3ViewController: UIViewController {

    @IBOutlet var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
            // Do any additional setup after loading the view.
        var filePath: String? = Bundle.main.path(forResource: "description", ofType: "txt")
        textView?.text = try? String(contentsOfFile: filePath!, encoding: String.Encoding.utf8)
        textView?.font = UIFont.systemFont(ofSize: CGFloat(22))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
