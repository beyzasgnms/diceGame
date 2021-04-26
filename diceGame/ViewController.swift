//
//  ViewController.swift
//  diceGame
//
//  Created by Beyza Sığınmış on 26.04.2021.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var lblPlayer1Scor: UILabel!
    @IBOutlet weak var lblPlayer2Scor: UILabel!
    @IBOutlet weak var lblPlayer1Gain: UILabel!
    @IBOutlet weak var lblPlayer2Gain: UILabel!
    @IBOutlet weak var imgPlayer1Status: UIImageView!
    @IBOutlet weak var imgPlayer2Status: UIImageView!
    @IBOutlet weak var imgDice1: UIImageView!
    @IBOutlet weak var imgDice2: UIImageView!
    @IBOutlet weak var lblSetResult: UILabel!
    
    var playerScors = (player1Scor: 0, player2Scor: 0)
    var playerGains = (player1Gain: 0, player2Gain: 0)
    var playerTurn: Int = 1
    
    var maxSet: Int = 5
    var currentSet: Int = 1
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if currentSet > maxSet {
            return
        }
        diceValueProduce()
    }
    
    func setResult(dice1: Int, dice2: Int){
        if playerTurn == 1 {
            //new set begin
            playerScors.player1Scor = dice1 + dice2
            lblPlayer1Gain.text = String(playerScors.player1Scor)
            imgPlayer1Status.image = UIImage(named: "bekle")
            imgPlayer1Status.image = UIImage(named: "onay")
            lblSetResult.text = "Second Player Turn"
            playerTurn = 2
            lblPlayer2Gain.text = "0"
        } else {
            playerScors.player2Scor = dice1 + dice2
            lblPlayer2Gain.text = String(playerScors.player2Scor)
            imgPlayer1Status.image = UIImage(named: "onay")
            imgPlayer1Status.image = UIImage(named: "bekle")
            playerTurn = 1
            //finalize set
            if playerScors.player1Scor > playerScors.player2Scor {
                //First player win game
                playerGains.player1Gain += 1
                lblSetResult.text = "\(currentSet).set player green face winner"
                currentSet += 1
                lblPlayer1Scor.text = String(playerGains.player1Gain)
            } else if playerScors.player2Scor > playerScors.player1Scor {
                //Second player win game
                playerGains.player2Gain += 1
                lblSetResult.text = "\(currentSet).set player blue face winner"
                currentSet += 1
                lblPlayer2Scor.text = String(playerGains.player2Gain)
            } else {
                //Dont change set
                lblSetResult.text = "\(currentSet).draw together"
            }
            playerScors.player1Scor = 0
            playerScors.player2Scor = 0
        }
    }
        
    func diceValueProduce(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3){
            let dice1 = arc4random_uniform(6) + 1
            let dice2 = arc4random_uniform(6) + 1
            self.imgDice1.image = UIImage(named: String(dice1))
            self.imgDice2.image = UIImage(named: String(dice2))
            
            self.setResult(dice1: Int(dice1), dice2: Int(dice2))
            if self.currentSet > self.maxSet {
                if self.playerGains.player1Gain > self.playerGains.player2Gain {
                    self.lblSetResult.text = "Green Face is winner!"
                } else {
                    self.lblSetResult.text = "Blue Face is winner!"
                }
            }
        }
        lblSetResult.text = "\(playerTurn) producing new dice value"
        imgDice1.image = UIImage(named:"bilinmeyenZar")
        imgDice2.image = UIImage(named: "bilinmeyenZar")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "arkaPlan")!)
    }
}


