//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Aayush Kapoor on 07/09/16.
//  Copyright © 2016 Aayush Kapoor. All rights reserved.
//

import AVFoundation
import UIKit

class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var darthVaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!

    @IBOutlet weak var outerStackView: UIStackView!

    @IBOutlet weak var innerStackView1: UIStackView!
    @IBOutlet weak var innerStackView2: UIStackView!
    @IBOutlet weak var innerStackView3: UIStackView!
    @IBOutlet weak var innerStackView4: UIStackView!

    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!

    enum ButtonType: Int {
        case Slow, Fast, Chipmunk, DarthVader, Echo, Reverb
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        setStackViewLayout()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.NotPlaying)
    }

    func setInnerStackViewsAxis(axisStyle: UILayoutConstraintAxis)  {
        innerStackView1.axis = axisStyle
        innerStackView2.axis = axisStyle
        innerStackView3.axis = axisStyle
        innerStackView4.axis = axisStyle
    }

    func setStackViewLayout() {
        let orientation = UIApplication.sharedApplication().statusBarOrientation

        if orientation.isPortrait {
            outerStackView.axis = .Vertical
            setInnerStackViewsAxis(.Horizontal)
        } else {
            outerStackView.axis = .Horizontal
            setInnerStackViewsAxis(.Vertical)
        }
    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animateAlongsideTransition({ context in
                self.setStackViewLayout()
            }, completion: nil)
    }

    @IBAction func playSoundForButton(sender: UIButton) {
        switch ButtonType(rawValue: sender.tag)! {
        case .Slow:
            playSound(rate: 0.5)
        case .Fast:
            playSound(rate: 1.5)
        case .Chipmunk:
            playSound(pitch: 1000)
        case .DarthVader:
            playSound(pitch: -1000)
        case .Echo:
            playSound(echo: true)
        case .Reverb:
            playSound(reverb: true)
        }

        configureUI(.Playing)

    }

    @IBAction func stopButtonPressed(sender: AnyObject) {
        stopAudio()
    }

}
