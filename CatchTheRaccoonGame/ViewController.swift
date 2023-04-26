//
//  ViewController.swift
//  CatchTheRaccoonGame
//
//  Created by Ali Rıza TAŞKIRAN on 26.04.2023.
//

import UIKit

class ViewController: UIViewController {

        //Variables
    
        var score = 0
        var timer = Timer()
        var counter = 0
        var raccoonArray = [UIImageView]()
        var hideTimer = Timer()
        var highscore = 0
    
        
    
        //Views
    
        @IBOutlet weak var timeLabel: UILabel!
        @IBOutlet weak var scoreLabel: UILabel!
        @IBOutlet weak var highscoreLabel: UILabel!
        @IBOutlet weak var raccoon1: UIImageView!
        @IBOutlet weak var raccoon2: UIImageView!
        @IBOutlet weak var raccoon3: UIImageView!
        @IBOutlet weak var raccoon4: UIImageView!
        @IBOutlet weak var raccoon5: UIImageView!
        @IBOutlet weak var raccoon6: UIImageView!
        @IBOutlet weak var raccoon7: UIImageView!
        @IBOutlet weak var raccoon8: UIImageView!
        @IBOutlet weak var raccoon9: UIImageView!
    
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score : \(score)"
        
        //Chech highscore
            
            let storedHighscore = UserDefaults.standard.object(forKey: "highscore")
        
            if storedHighscore == nil {
                highscore = 0
                highscoreLabel.text = "Highscore : \(highscore)"
            }
            
            if let newScore = storedHighscore as? Int {
                highscore = newScore
                highscoreLabel.text = "Highscore : \(highscore)"
            }
            
        //Images
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        raccoon1.addGestureRecognizer(recognizer1)
        raccoon2.addGestureRecognizer(recognizer2)
        raccoon3.addGestureRecognizer(recognizer3)
        raccoon4.addGestureRecognizer(recognizer4)
        raccoon5.addGestureRecognizer(recognizer5)
        raccoon6.addGestureRecognizer(recognizer6)
        raccoon7.addGestureRecognizer(recognizer7)
        raccoon8.addGestureRecognizer(recognizer8)
        raccoon9.addGestureRecognizer(recognizer9)
        
        raccoon1.isUserInteractionEnabled = true
        raccoon2.isUserInteractionEnabled = true
        raccoon3.isUserInteractionEnabled = true
        raccoon4.isUserInteractionEnabled = true
        raccoon5.isUserInteractionEnabled = true
        raccoon6.isUserInteractionEnabled = true
        raccoon7.isUserInteractionEnabled = true
        raccoon8.isUserInteractionEnabled = true
        raccoon9.isUserInteractionEnabled = true
        
        raccoonArray = [raccoon1, raccoon2, raccoon3, raccoon4, raccoon5, raccoon6, raccoon7, raccoon8, raccoon9]
            
            
            
        //Timers
        
            counter = 10
            timeLabel.text = String(counter)
        
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
            hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideRaccoon), userInfo: nil, repeats: true)
        
    }
    
    @objc func hideRaccoon(){
        
        for raccoon in raccoonArray{
            raccoon.isHidden = true;
        }
        
        let random = Int(arc4random_uniform(UInt32(raccoonArray.count - 1)))
        raccoonArray[random].isHidden = false
        
        
        
    }
    
    
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score : \(score)"
    }
    
    @objc func countDown() {
        counter -= 1
        timeLabel.text = String(counter)
        
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for raccoon in raccoonArray{
                raccoon.isHidden = true;
            }
            
            //Highscore
            
            if self.score > self.highscore{
                
                self.highscore = self.score
                highscoreLabel.text = "Highscore : \(highscore)"
                UserDefaults.standard.set(self.highscore, forKey: "highscore")
                
            }
            
            
            //Alert
            
            let alert = UIAlertController(title: "Time's Up!", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default){
                (UIAlertAction) in
                //Replay Function
                                        //Score ve Time sıfırlandı ve labellara atandı. Bu sayede oyun tekrar başladı.
                self.counter = 10
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
            
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideRaccoon), userInfo: nil, repeats: true)
                
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
    }
    
}

