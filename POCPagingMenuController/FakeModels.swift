//
//  FakePresenterModels.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 19/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation

// MARK: - DOMAIN  LAYER -

/// Domain object
struct Question {
    let id: String
    let mandatory: Bool
    let title: String
    let type: Layout
    let validation: ValidationKind
}

enum Layout {
    case singleInput
    case singleSelection(options: [String])
}


// MARK: - PRESENTER LAYER -

/// The object that contains all data that is needed to display the view
struct QuestionOutput {
    
}

/// The object that contains all data gathered by the view
struct Input {
    //    let relatedQuestionId: String
    let id: String
    let data: String
}

struct AnswerCompilation {
    let relatedQuestionId: String
    let inputs: [Input]
}

