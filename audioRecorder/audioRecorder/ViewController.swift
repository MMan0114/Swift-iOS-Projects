//  ViewController.swift
//  audioRecorder
//
//  Created by MMan on 11/30/16.
//  Copyright © 2016 MananKothari. All rights reserved.
//
import UIKit
import AVFoundation
class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    @IBOutlet var playButton: UIButton!
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var stopButton: UIButton!

    @IBAction func recordButton(_ sender: Any) {
        if !(audioRecorder?.isRecording)! {
            playButton.isEnabled = false
            recordButton.isEnabled = false
            stopButton.isEnabled = true
            audioRecorder?.record()
        }
    }

    @IBAction func playButton(_ sender: Any) {
        stopButton.isEnabled = true
        recordButton.isEnabled = false
        playButton.isEnabled = false
        var error: Error? = nil
        audioPlayer = try? AVAudioPlayer(contentsOf: (audioRecorder?.url)!)
        audioRecorder?.delegate = self
        if error != nil {
            print("error:\(error?.localizedDescription)")
            stopButton.isEnabled = false
        }
        else {
            audioPlayer?.play()
        }
    }

    @IBAction func stopButton(_ sender: Any) {
        stopButton.isEnabled = false
        playButton.isEnabled = true
        //User may play recorded audio
        recordButton.isEnabled = true
        //User may record over existing audio
        //two possibilites stop recording or stop playing
        if (audioRecorder?.isRecording)! {
            audioRecorder?.stop()
        }
        if (audioPlayer?.isPlaying)! {
            audioPlayer?.stop()
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //disable play and stop buttons
        playButton.isEnabled = false
        stopButton.isEnabled = false
            //setup recording options
        var dirPaths: [Any] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        var docsDir: String? = (dirPaths[0] as? String)
        var soundFilePath: String = URL(fileURLWithPath: docsDir!).appendingPathComponent("myRecording.caf").absoluteString
        var soundFileURL = URL(fileURLWithPath: soundFilePath)
        var recordSettings: [AnyHashable: Any] = [
                AVEncoderAudioQualityKey : Int(32),
                AVEncoderBitRateKey : Int(16),
                AVNumberOfChannelsKey : Int(2),
                AVSampleRateKey : Int(44100)
            ]

        var error: Error? = nil
        audioRecorder = try? AVAudioRecorder(url: soundFileURL, settings: recordSettings as! [String : Any])
        if error != nil {
            print("error:\(error?.localizedDescription)")
            recordButton.isEnabled = false
        }
        else {
            //recoder is all set to go
            audioRecorder?.prepareToRecord()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
// MARK: - Action Methods
// MARK: - Recorder Delegates

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        //Player reached end of audio file
        stopButton.isEnabled = false
        recordButton.isEnabled = true
    }

    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) throws {
        print("AudioPlayer decoder error:\(error?.localizedDescription)")
    }

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("Recorder finished recording")
    }
}
