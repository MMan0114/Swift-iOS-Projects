//  ViewController.swift
//  audioPlayer
//
//  Created by MMan on 10/12/16.
//  Copyright © 2016 MananKothari. All rights reserved.
//
import UIKit
import AVFoundation
class ViewController: UIViewController {

    var player: AVAudioPlayer?
    var timer: Timer?
    @IBOutlet var avgVolume: UIProgressView!
    @IBOutlet var peakVolume: UIProgressView!
    @IBOutlet var playPausebttn: UIButton!
    @IBOutlet var volumeSlider: UISlider!
    @IBOutlet var timeScale: UISlider!

    var path: String = ""

    @IBAction func play(_ sender: Any) {
        if (playPausebttn.currentImage?.isEqual(UIImage(named: "playButton.png")))! {
            volumeSlider.value = (player?.volume)!
    
            volumeSlider.isEnabled = true
            //switch label text
            playPausebttn.setImage(UIImage(named: "pauseButton.png"), for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.updateUI), userInfo: nil, repeats: true)
            playPausebttn.isEnabled = true
            player?.play()
        }
        else if (playPausebttn.currentImage?.isEqual(UIImage(named: "pauseButton.png")))! {
            //switch label text
            playPausebttn.setImage(UIImage(named: "playButton.png"), for: .normal)
            playPausebttn.isEnabled = true
            timer?.invalidate()
            player?.pause()
        }

    }

    @IBAction func changeVolume(_ sender: Any) {
        player?.volume = volumeSlider.value
    }

    @IBAction func changePlayerTime(_ sender: Any) {
        player?.currentTime = TimeInterval(timeScale.value)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            //Prep audio player
        var myError: Error?
        path = Bundle.main.path(forResource: "03 No Sugar No Cream", ofType: "mp3")!
        player = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        player?.prepareToPlay()
        timeScale.minimumValue = 0
        timeScale.maximumValue = Float(Int((player?.duration)!))
        player?.isMeteringEnabled = true
        avgVolume.progress = 0.0
        peakVolume.progress = 0.0
        playPausebttn.setImage(UIImage(named: "playButton.png"), for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateUI(_ sender: Any) {
        player?.updateMeters()
        var avg: Float? = -1 * (player?.averagePower(forChannel: 0))!
        var peak: Float? = -1 * (player?.peakPower(forChannel: 0))!
        avgVolume.progress = avg! / 20
        peakVolume.progress = peak! / 20
        timeScale.value = Float(Int((player?.currentTime)!))
        print("avg \(avg)\n peak \(peak)\n avgProgress \(avgVolume.progress)\n peakProgress \(peakVolume.progress) \n")
        print("playing \(player?.isPlaying)")
        if (player?.isPlaying)! {
            timer?.invalidate()
            playPausebttn.setImage(UIImage(named: "playButton.png"), for: .normal)
            timeScale.value = 0
            playPausebttn.isEnabled = true
        }
    }
}
