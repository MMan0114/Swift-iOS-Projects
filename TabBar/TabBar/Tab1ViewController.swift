//  ViewController.h
//  TabBar
//
//  Created by MMan on 9/21/16.
//  Copyright © 2016 MananKothari. All rights reserved.
//
import UIKit
class Tab1ViewController: UIViewController {

    @IBOutlet var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
        var filePath: String? = Bundle.main.path(forResource: "albums", ofType: "txt")
        textView?.text = try? String(contentsOfFile: filePath!, encoding: String.Encoding.utf8)
        textView?.font = UIFont.systemFont(ofSize: CGFloat(22))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
