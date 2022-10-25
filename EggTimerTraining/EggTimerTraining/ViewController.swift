//
//  ViewController.swift
//  EggTimerTraining
//
//  Created by Zulfikar Abdul Rahman Suwardi on 20/10/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var progressBar: UIProgressView!
  
  let eggTimes = ["Soft": 300, "Medium": 480, "Hard": 720]
  var timer = Timer()
  var totalTime = 0
  var secondsPassed = 0
  
  var player: AVAudioPlayer!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  @IBAction func eggPressed(_ sender: UIButton) {
    
    timer.invalidate() // to cancel if we click another timer
    let hardness = sender.currentTitle!
    totalTime = eggTimes[hardness]!
    
    // to reset progress bar to zero
    progressBar.progress = 0
    secondsPassed = 0
    titleLabel.text = hardness
    
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
  }
  
  @objc func updateTimer() {
      if secondsPassed < totalTime {
        secondsPassed += 1
        
        // percentageProgress = secondsPassed / totalTime
        progressBar.progress = Float(secondsPassed) / Float(totalTime)
        print(progressBar.progress)
        
      } else {
        timer.invalidate()
        titleLabel.text = "DONE"
        playSound()
      }
  }
  
  func playSound() {
    let url = Bundle.main.url(forResource: "alarm_sound" , withExtension: "mp3")
    player = try! AVAudioPlayer(contentsOf: url!)
    player.play()
  }
  
}


