//
//  GameViewController.swift
//  gotgame
//
//  Created by Marlon Escobar on 2019-05-01.
//  Copyright © 2019 Marlon Escobar A. All rights reserved.
//

import Foundation
import UIKit
import FirebaseUI

class GameViewController: UIViewController {
    
    var pickedAnswer:Bool!
    var ref:DatabaseReference!//1 to read
    var dataBaseHandle:DatabaseHandle!//3 to read
    var counter = 0
    var counterQuestion = 0
    var indexSeason = 0
    var indexCondition = 0
    var indexCompetitor = 0
    var indexCompetitor2 = 0
    var timeCompetitor1: Float!
    var timeCompetitor2: Float!
    var score = 0
    let ALERTMESSAGE = "You\'ve already finished all the questions, do you want to start over the GAME?"
    let ALERTTITLE = "Result"
    let ALERTACTIONMESSAGE = "Accept"
    var posData = [Question]()
    var times = [Float]()
    var season: String!
    var answers = [" CORRECT ANSWER "," INCORRECT ANSWER "]
    var seasons = ["Season1","Season2","Season3","Season4","Season5","Season6","Season7"]
    
    enum Answer: String {
        case CORRECT = "Correct Answer"
        case INCORRECT = "Incorrect Answer"
    }
    
    @IBOutlet weak var userScore: UITextView!
    @IBOutlet weak var userName: UITextView!
    @IBOutlet weak var competitor1: UITextView!
    @IBOutlet weak var condition: UITextView!
    @IBOutlet weak var competitor2: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let player = Auth.auth().currentUser?.email
        userName.text = player
        //                SET FIREBASE REFERENCE
        ref = Database.database().reference()//2 to read
        dataBaseHandle = ref?.child("QuestionBank").observe(.value, with: { (snapshot) in
            guard let data = snapshot.value as? [String:[String:Any]]  else{
                return
            }
            
            for(l,val) in data{
                self.times = [Float]()
                self.times.append(val["season1"] as! Float)
                self.times.append(val["season2"] as! Float)
                self.times.append(val["season3"] as! Float)
                self.times.append(val["season4"] as! Float)
                self.times.append(val["season5"] as! Float)
                self.times.append(val["season6"] as! Float)
                self.times.append(val["season7"] as! Float)
                let newObj = Question(name:val["name"] as! String, times: self.times)
                print(l,"\n##################\n")
                self.posData.append(newObj)
            }
            self.nextQuestion()
        })// Do any additional setup after loading the view.
    }
    
    
    @IBAction func answerTapped(_ sender: UIButton) {
        if sender.tag == 1{
            pickedAnswer = true
        }
        else{
            pickedAnswer = false
        }
        //        counter += 1
        checkAnswer()
 
    }
    
    
    func updateUI() {
        userScore.text = String(score)

    }
    
    
    func nextQuestion() {
        indexSeason = Int.random(in: 0...6)
        season = seasons[indexSeason]
        if counterQuestion < 5 {
            indexCompetitor = Int.random(in: 0...6)
            let character1 = posData[indexCompetitor].name
            competitor1.text = " Time on Screen of \(character1) was ..."
            timeCompetitor1 = Float(posData[indexCompetitor].times[indexSeason])
            
            indexCondition = Int.random(in: 0...2)
//            let compare = conditions[indexCondition]
            condition.text = "GREATER THAN"
            
            indexCompetitor2 = Int.random(in: 0...6)

            let character2 = posData[indexCompetitor2].name
            competitor2.text = "Time on Screen of \(character2) during \(season)"
            timeCompetitor2 = Float(posData[indexCompetitor2].times[indexSeason])

        }
        else{
            printMessages(message: ALERTMESSAGE)
            startOver()
        }

    }

    func checkAnswer() {
        if ((timeCompetitor1 > timeCompetitor2 && pickedAnswer) || (!(timeCompetitor1 > timeCompetitor2) && !pickedAnswer)){
            score += 1
            userScore.text = String(score)
            printMessages(message: answers[0])
           
        }
            else{
            printMessages(message: answers[1])
        }

        counterQuestion += 1
        nextQuestion()
    }

    func startOver() {
        print ("New Game!")
        score = 0
        counterQuestion = 0
        indexSeason = 0
        indexCondition = 0
        indexCompetitor = 0
        nextQuestion()
        userScore.text = "0"
    }
    
    func printMessages(message: String){
        let alert = UIAlertController(title: ALERTTITLE, message: message, preferredStyle: .alert)
        
        let restartAction = UIAlertAction(title: ALERTACTIONMESSAGE, style: .default) { (UIAlertAction) in
            
        }
        
        alert.addAction(restartAction)
        
        //PRESENT ALERT TO THE VIEWER
        present(alert, animated: true,completion: nil)
    }
    

}
