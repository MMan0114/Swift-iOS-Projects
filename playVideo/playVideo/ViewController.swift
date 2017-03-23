//  ViewController.swift
//  playVideo
//
//  Created by MMan on 10/12/16.
//  Copyright © 2016 MananKothari. All rights reserved.
//
import UIKit
import MediaPlayer
class ViewController: UIViewController {
    var player: MPMoviePlayerController?



    override func viewDidLoad() {
        super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
        var url: String? = Bundle.main.path(forResource: "Pipe Dream", ofType: "m4v")
        player = MPMoviePlayerController(contentURL: URL(fileURLWithPath: url!))
        NotificationCenter.default.addObserver(self, selector: #selector(self.movieFinishedCallBack), name: NSNotification.Name.MPMoviePlayerPlaybackDidFinish, object: player)
        player?.view?.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(self.view.frame.size.width), height: CGFloat(self.view.frame.size.height))
        self.view.addSubview((player?.view)!)
        //Play movie
        player?.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func movieFinishedCallBack(_ aNotification: Notification) {
        var moviePlayer: MPMoviePlayerController? = aNotification.object as! MPMoviePlayerController?
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.MPMoviePlayerPlaybackDidFinish, object: moviePlayer)
    }
}
