//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    
    let originalTitleText = "How do you like your eggs?"
    let finishedTitleText = "DONE!"
    
    let eggTimes = [
        "Soft": 5,
        "Medium": 8,
        "Hard": 12
    ]
    
    var secondsRemaining = 0
    var totalTime = 0
    
    var timer = Timer()

    @IBOutlet weak var mainTitle: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureProgressBarStyles()
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        let hardness = sender.currentTitle!
        
        totalTime = minToSec(minutes: eggTimes[hardness]!)
        
        secondsRemaining = totalTime
    
        timer.invalidate()
        mainTitle.text = originalTitleText
        progressBar.setProgress(0.0, animated: false)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    
    func minToSec(minutes: Int) -> Int {
        return minutes * 60
    }
   
    @objc func updateTimer() {
        if secondsRemaining > 0 {
            
            secondsRemaining -= 1
            
            let percent = 1 - Float(secondsRemaining) / Float(totalTime)
            
            progressBar.setProgress(percent, animated: true)
            
        } else {
            timer.invalidate()
            mainTitle.text = finishedTitleText
            playSound()
        }
    }
    
    func configureProgressBarStyles() {
        
        progressBar.layer.cornerRadius = 4
        progressBar.clipsToBounds = true
    }

    func playSound() {
        let path = Bundle.main.path(forResource: "alarm_sound.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Error to reproduce audio")
        }
    }

}
