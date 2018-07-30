//
//  Answer.swift
//  DynamicRadioButtons
//
//  Created by Omar Tovias on 7/30/18.
//  Copyright © 2018 com.hermestovias. All rights reserved.
//

import ObjectMapper

class Answer: Mappable {
    
    var idAnswer: Int = 0
    var answer: String? = ""
    
    init(idAnswer: Int, answer: String) {
        self.idAnswer = idAnswer
        self.answer = answer
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        idAnswer <- map["idAnswer"]
        answer <- map["answer"]
    }
}
