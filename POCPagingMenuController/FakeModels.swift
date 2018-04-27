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
    case singleInput(keyboard: KeyboardType)
    case singleDate
    case singleSelection(options: [String])
}

enum KeyboardType {
    case number
    case phone
    case email
    case name
    case `default`
}

// MARK: - PRESENTER LAYER -

/// The object that contains all data that is needed to display the view
struct QuestionOutput {
    let id: String
    let title: String
    let inputLayout: Layout
}

/// The object that contains all data gathered by the view
struct Input {
    let id: String
    let data: Any
}

//struct TextInput: AnswerProtocol {
//    typealias T = String
//
//    var id: String
//    var data: String
//}
//
//struct DateInput: AnswerProtocol {
//    typealias T = Date
//
//    var id: String
//    var data: Any
//
//}
//
//protocol AnswerProtocol {
//    associatedtype T
//    var id: String { get }
//    var data: T { get set }
//}

struct AnswerCompilation {
    let relatedQuestionId: String
    let inputs: [Input]
}

