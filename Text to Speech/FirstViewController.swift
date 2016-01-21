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

    @IBOutlet weak var textView: UITextView!
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
        inputText = textView.text
        
        if(!inputText.isEmpty && textView.textColor != UIColor.lightGrayColor()){
            playButton.hidden = true
            stopButton.hidden = false
            
            let utterance = AVSpeechUtterance(string: inputText)
            utterance.rate = speechSpeed
            
            self.synthesizer.speakUtterance(utterance)
            self.synthesizer.delegate = self

        }else{
            playButton.hidden = false
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
        if (textView.textColor == UIColor.lightGrayColor()) {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if (textView.text == "" || textView.text == nil) {
            textView.text = "Enter Text"
            textView.textColor = UIColor.lightGrayColor()
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"
        {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speechSpeed = 0.5
        stopButton.hidden = true
        textView.text = "Enter Text  "
        textView.textColor = UIColor.lightGrayColor()
        textView.delegate = self
        textView.layer.cornerRadius = 10.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // consider making a function to simply hide or show the play and stop buttons
}