//
//  FirstViewController.swift
//  Text to Speech
//
//  Created by Manu Sodhi on 12/20/15.
//  Copyright © 2015 Manvinder Sodhi. All rights reserved.
//

import UIKit
import AVFoundation

class FirstViewController: UIViewController, AVSpeechSynthesizerDelegate, UITextViewDelegate{

    @IBOutlet weak var inputField: UITextView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var speedSlider : UISlider!
    @IBOutlet weak var stopButton: UIButton!
    
    var speechSpeed : Float!
    var inputText : String!
    
    let synthesizer = AVSpeechSynthesizer()
    
    @IBAction func sliderValue(sender: UISlider) {
        speechSpeed = Float(sender.value)
    }
    
    @IBAction func textToSpeech(sender: AnyObject) {
        inputText = inputField.text
        let utterance = AVSpeechUtterance(string: inputText)
        utterance.rate = speechSpeed
        
        self.synthesizer.speakUtterance(utterance)
        self.synthesizer.delegate = self
        
        if(!inputText.isEmpty){
            playButton.hidden = true
            stopButton.hidden = false
        }
    }
    
    @IBAction func stopSpeech(sender: AnyObject) {
        synthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        playButton.hidden = false
        stopButton.hidden = true
    }
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didFinishSpeechUtterance utterance: AVSpeechUtterance) {
        playButton.hidden = false
        stopButton.hidden = true
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if inputField.textColor == UIColor.lightGrayColor() {
            inputField.text = nil
            inputField.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        print("empty")
        if (inputField.text == "" || inputField.text == nil) {
            inputField.text = "Enter Text"
            inputField.textColor = UIColor.lightGrayColor()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speechSpeed = 0.5
        stopButton.hidden = true
        inputField.text = "Enter Text"
        inputField.textColor = UIColor.lightGrayColor()
        self.inputField.delegate = self
        inputField.layer.cornerRadius = 10.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // consider making a function to simply hide or show the play and stop buttons
}