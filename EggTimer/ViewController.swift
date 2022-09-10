//
//  ViewController.swift
//  EggTimer
//
//  Created by Jenny Mikac on 08/30/2022.
//  for Angela Yu's iOS Development Course on Udemy
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes: [String : Int] = ["Soft": 3,"Medium": 4,"Hard": 7]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    @IBOutlet weak var timePassed: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    var player: AVAudioPlayer?
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        timePassed.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            timePassed.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            playSound()
            timer.invalidate()
            titleLabel.text = "DONE!"
        }
    }
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
                return }
            let url = URL(fileURLWithPath: path)

            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
                
            } catch let error {
                print(error.localizedDescription)
            }
    }
}
