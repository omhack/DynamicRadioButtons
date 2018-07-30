//
//  Poll.swift
//  DynamicRadioButtons
//
//  Created by Omar Tovias on 7/30/18.
//  Copyright © 2018 com.hermestovias. All rights reserved.
//

import ObjectMapper

class Poll: Mappable {
    
    var idQuestion: Int = 0
    var idAnswer: Int = 0
    
    init() {
    }
    
    init(idQuestion: Int, idAnswer: Int) {
        self.idQuestion = idQuestion
        self.idAnswer = idAnswer
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        idQuestion <- map["idQuestion"]
        idAnswer <- map["idAnswer"]
    }
}

