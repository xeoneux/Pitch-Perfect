//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Aayush Kapoor on 06/09/16.
//  Copyright © 2016 Aayush Kapoor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: AnyObject) {
        self.recordingLabel.text = "Recording in progress"
    }

    @IBAction func stopRecording(sender: AnyObject) {
        print("Stop Recording button pressed")
    }

}

