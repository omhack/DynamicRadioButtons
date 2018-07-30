//
//  Questions.swift
//  DynamicRadioButtons
//
//  Created by Omar Tovias on 7/30/18.
//  Copyright © 2018 com.hermestovias. All rights reserved.
//

import UIKit
import DLRadioButton

//Delegate to manage the Polls
protocol QuestionsDialogDelegate : class{
    func questionsAnswered(polls: [Poll])
}

class QuestionsDialog: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet var rootView: UIView!
    @IBOutlet weak var nestedView: UIView!
    weak var delegate: QuestionsDialogDelegate?
    var questions : [Question]!
    var polls = [Poll]()
    var serviceType : Int = 0
    var indexView : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting the stack view properties
        stackView.alignment = UIStackViewAlignment.leading
        stackView.axis = .vertical
        
    }
    
    //this is where the heavy logic, to create the dynamic radio buttons takes place
    func showQuestions(){
        
        if(questions.count <= 1){
            rootView.frame.size.height = 200
            nestedView.frame.size.height = 200
        }else{
            rootView.frame.size.height = 400
            nestedView.frame.size.height = 400
        }
        
        for question in questions{
            var otherButtons : [DLRadioButton] = []
            
            let frame1 = CGRect(x: self.view.frame.size.width / 2 - 131, y: 350, width: 262, height: 17);
            //we create a base radio button to use it as an anchor view
            let firstRadioButton = createRadioButton(frame: frame1, title: "", color: UIColor.purple);
            
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 17.0)
            label.textColor = UIColor.darkGray.withAlphaComponent(0.85)
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.25
            label.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
            label.text = question.question
            
            self.stackView.insertArrangedSubview(label, at: self.indexView)
            
            self.indexView += 1
            let poll = Poll()
            poll.idQuestion = question.idQuestion
            
            var i = 0;
            for answer in question.answers{
                
                let frame = CGRect(x: self.view.frame.size.width / 2 - 131, y: 380 + 30 * CGFloat(i), width: 300, height: 17);
                let radioButton = createRadioButton(frame: frame, title: answer.answer! + " ", color: UIColor.purple)
                radioButton.tag = answer.idAnswer
                radioButton.params["poll"] = poll
                otherButtons.append(radioButton)
                self.stackView.insertArrangedSubview(radioButton, at: self.indexView)
                i += 1;
                self.indexView += 1
            }
            
            
            firstRadioButton.otherButtons = otherButtons
            firstRadioButton.isHidden = true
            firstRadioButton.otherButtons[1].isSelected = true
            
        }
    }
    
    //Method to create a custom button
    private func createRadioButton(frame : CGRect, title : String, color : UIColor) -> MyDLUIButton {
        let radioButton = MyDLUIButton(frame: frame);
        radioButton.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: 14);
        radioButton.setTitle(title, for: []);
        radioButton.setTitleColor(UIColor.darkGray, for: []);
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(QuestionsDialog.selectedAnswer(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    
    
    @objc func selectedAnswer(_ sender: MyDLUIButton){
        
        let poll = sender.params["poll"] as? Poll
        poll?.idAnswer = sender.tag
        
        
        if let row = self.polls.index(where: {$0.idQuestion == poll?.idQuestion}) {
            self.polls[row] = poll!
        }else{
            self.polls.append(poll!)
        }
        
        
        print("polls size: \(self.polls.count)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if(self.polls.count < self.questions.count){
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "questionsDialogDismissed"), object: nil)
        }
    }
    
    @IBAction func requestService(_ sender: UIButton) {
        delegate?.questionsAnswered(polls: self.polls)
    }
    
}

class  MyDLUIButton: DLRadioButton{
    var params: Dictionary<String, Any>
    override init(frame: CGRect) {
        self.params = [:]
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.params = [:]
        super.init(coder: aDecoder)
    }
}





