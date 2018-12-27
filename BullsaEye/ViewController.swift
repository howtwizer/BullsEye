//
//  ViewController.swift
//  BullsaEye
//
//  Created by Oleksii Baidan on 12/18/18.
//  Copyright © 2018 Oleksii Baidan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
        startNewGame()
        
        let thumImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumImageNormal, for: .normal)
        
        let thumbImageHighligted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighligted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizeable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizeable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizeable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizeable, for: .normal)
    }

    @IBAction func showAlert(){
        
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        score += points

        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almoust had it!"
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "You even no close!"
        }


        let message = "You scored \(points) points"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.startNewRound()
        } )
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)

    }
    
    @IBAction func sliderMoved(_ slider: UISlider){
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
    }

    @IBAction func startOver(){
        startNewGame()
    }

    func startNewRound(){
        round += 1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }

    func startNewGame(){
        score = 0
        round = 0
        startNewRound()
    }
}

