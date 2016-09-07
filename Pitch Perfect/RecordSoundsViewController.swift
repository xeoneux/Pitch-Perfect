//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Aayush Kapoor on 06/09/16.
//  Copyright © 2016 Aayush Kapoor. All rights reserved.
//

import AVFoundation
import UIKit

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder:AVAudioRecorder!

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        stopRecordingButton.enabled = false
    }

    func configureUIForRecording(flag: Bool, message: String) {
        recordButton.enabled = flag
        stopRecordingButton.enabled = !flag
        recordingLabel.text = message
    }

    @IBAction func recordAudio(sender: AnyObject) {
        configureUIForRecording(false, message: "Recording in progress")

        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)

        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    @IBAction func stopRecording(sender: AnyObject) {
        configureUIForRecording(true, message: "Tap to Record")

        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }

    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
        } else {
            print("Save of recording failed")
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "stopRecording" {
            let playSoundsViewController = segue.destinationViewController as! PlaySoundsViewController

            let recordedAudioURL = sender as! NSURL
            playSoundsViewController.recordedAudioURL = recordedAudioURL
        }
    }

}

