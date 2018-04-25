//
//  ContainerViewModelProtocol.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 25/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation

protocol ContainerViewModelProtocol {
    
    mutating func getNextQuestions() -> [Question]
    func hasNextPage() -> Bool
    func hasPreviousPage() -> Bool
    func nextPageIndex() -> Paging.ChangeStatus
    func previousPageIndex() -> Paging.ChangeStatus
    mutating func updateCurrentPage(index: Int)
    mutating func save(compilation: AnswerCompilation)
    func sendCompilation()
    mutating func clearCurrentState()
    
    func inputTextChanged(newText: String) -> ValidationStatus
    func selected(amount: Int) -> ValidationStatus
    
}
