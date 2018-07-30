//
//  Question.swift
//  DynamicRadioButtons
//
//  Created by Omar Tovias on 7/30/18.
//  Copyright © 2018 com.hermestovias. All rights reserved.
//

import ObjectMapper

class Question: Mappable {
    
    var idQuestion: Int = 0
    var question: String? = ""
    var answers: [Answer] = []
    
    init(idQuestion: Int, question: String, answers: [Answer]) {
        self.idQuestion = idQuestion
        self.question = question
        self.answers = answers
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        idQuestion <- map["idQuestion"]
        question <- map["question"]
        answers <- map["answers"]
    }
}
