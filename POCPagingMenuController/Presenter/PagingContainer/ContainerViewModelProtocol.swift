//
//  ContainerViewModelProtocol.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 25/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation

protocol ContainerViewModelProtocol {
    
    func getNextQuestions() -> [QuestionOutput]
    func save(compilation: AnswerCompilation)
    func sendCompilation()
    
    func hasNextPage() -> Bool
    func hasPreviousPage() -> Bool
    func nextPageIndex() -> Paging.ChangeStatus
    func previousPageIndex() -> Paging.ChangeStatus
    func updateCurrentPage(index: Int)
    
//    func inputTextChanged(newText: String) -> ValidationStatus
//    func inputDateChanged(newDate: Date) -> ValidationStatus
//    func selected(amount: Int) -> ValidationStatus
    func inputChanged<T>(newInput: T) -> ValidationStatus
    func canMoveForward() -> Bool
}
