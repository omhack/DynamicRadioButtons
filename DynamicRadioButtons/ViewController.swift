//
//  ViewController.swift
//  DynamicRadioButtons
//
//  Created by Omar Tovias on 7/30/18.
//  Copyright © 2018 com.hermestovias. All rights reserved.
//

import UIKit
import LSDialogViewController

class ViewController: UIViewController, QuestionsDialogDelegate {
    
    var questions = [Question]()
    
    var polls = [Poll]()
    let numberOfAnswers : Int = 3
    let numberOfQuestions : Int = 6
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creating hardcoded data source, take note that the Mapped objects can be used with a response from a Web service using Alamofire
        
        for number in 0..<(numberOfQuestions){
            var answers = [Answer]()
            
            for answerNumber in 0..<(numberOfAnswers){
                let answer =  Answer(idAnswer: answerNumber, answer: "Answer \(answerNumber)")
                answers.append(answer)
            }
            
            let question = Question(idQuestion: number, question: "Question number \(number)", answers: answers)
            
            self.questions.append(question)
        }
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dialogBtnPressed(_ sender: Any) {
        showQuestionsDialog()
    }
    

    //Shows the dialog with the array of questions
    func showQuestionsDialog(){
        
        let dialogViewController: QuestionsDialog = QuestionsDialog(nibName:"QuestionsDialog", bundle: nil)
        dialogViewController.view.tag = 1007
        dialogViewController.delegate = self
        
        self.presentDialogViewController(dialogViewController, animationPattern: .zoomInOut, completion: { () -> Void in
            dialogViewController.questions = self.questions
            dialogViewController.showQuestions()
            
        })
        
    }
    
    //This is where you can manage the answers from user
    func questionsAnswered(polls: [Poll]) {
        self.polls = polls
        self.dismissDialogViewController(.fadeInOut)
    }

}

