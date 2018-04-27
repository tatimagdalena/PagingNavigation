//
//  FakeDataLayer.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 19/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation

struct FakeDataLayer {
    
    // just to alternate between fake questions
    static private var control = -1
    
    private let emailRegex = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
    
    func getQuestionCluster() -> [Question] {
        
        FakeDataLayer.control += 1
        
        if FakeDataLayer.control % 2 == 0 {
            let question1 = Question(id: "wijzommdpowe", mandatory: true, title: "CPF Field, loop \(FakeDataLayer.control)", type: .singleInput(keyboard: .number), validation: .cpf)
            let question2 = Question(id: "jdklajsdmkad", mandatory: true, title: "Single selection, loop \(FakeDataLayer.control)", type: .singleSelection(options: ["option #1", "option #2"]), validation: .singleChoice)
            let question3 = Question(id: "soiaJIODJiOHOI", mandatory: true, title: "Date Field, loop \(FakeDataLayer.control)", type: .singleDate, validation: .date(after: Date(timeIntervalSince1970: 0), before: Date()))
            return [question3, question1, question2]
        }
        else {
            let question1 = Question(id: "sioawiodea", mandatory: true, title: "Single selection, loop \(FakeDataLayer.control)", type: .singleSelection(options: ["option #1", "option #2"]), validation: .none)
            let question2 = Question(id: "jaiosjaiow",  mandatory: true, title: "Single selection, loop \(FakeDataLayer.control)", type: .singleSelection(options: ["option #101", "option #102"]), validation: .none)
            let question3 = Question(id: "pqowpapods", mandatory: true, title: "Email field, loop \(FakeDataLayer.control)", type: .singleInput(keyboard: .email), validation: .string(regex: emailRegex))
            let question4 = Question(id: "iwopiapsjd", mandatory: false, title: "Single text input, loop \(FakeDataLayer.control)", type: .singleInput(keyboard: .default), validation: .none)
            return [question1, question2, question3, question4]
        }
    }
    
}
