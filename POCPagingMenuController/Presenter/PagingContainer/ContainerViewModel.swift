//
//  ContainerViewModel.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 17/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation

class ContainerViewModel: ContainerViewModelProtocol {

    // Collaborators
//    var validatorFactory = ValidatorFactory()
    
    // State
    var currentPageIndex = 0
    var pages = [Paging.Page]()
    
    private var compilationCluster = [AnswerCompilation?]()
    
    // MARK: - Data -
    
    func getNextQuestions() -> [Question] {
        let questionCluster = FakeDataLayer().getQuestionCluster()
        compilationCluster = [AnswerCompilation?](repeating: nil, count: questionCluster.count)
        
        for index in questionCluster.indices {
            let question = questionCluster[index]
            let page = Paging.Page(index: index, isMandatory: question.mandatory, validation: question.validation)
            pages.append(page)
        }
        currentPageIndex = 0
        
        return questionCluster
    }
    
    func save(compilation: AnswerCompilation) {
        compilationCluster[currentPageIndex] = compilation
    }
    
    func sendCompilation() {
        print("** SEND INPUTS TO API **")
        
        for compilation in compilationCluster {
            if let compilation = compilation {
                print("Question: \(compilation.relatedQuestionId)")
                for input in compilation.inputs {
                    print("Answer \(input.id): \(input.data)")
                }
                print("---")
            }
        }
        
    }
    
    func clearCurrentState() {
        currentPageIndex = 0
        pages = []
        compilationCluster = []
    }
    
    // MARK: - Paging Control -
    
    func hasNextPage() -> Bool {
        return currentPageIndex < (pages.count - 1)
    }
    
    func hasPreviousPage() -> Bool {
        return currentPageIndex > 0
    }
    
    func nextPageIndex() -> Paging.ChangeStatus {
        if hasNextPage() {
            return .canMoveToNext(newPage: currentPageIndex + 1)
        }
        return .reachedEnd
    }
    
    func previousPageIndex() -> Paging.ChangeStatus {
        if hasPreviousPage() {
            return .canMoveToPrevious(newPage: currentPageIndex - 1)
        }
        return .reachedBeggining
    }
    
    func updateCurrentPage(index: Int) {
        currentPageIndex = index
    }
   
    // MARK: - Validation -
    
    func inputTextChanged(newText: String) -> ValidationStatus {
        let page = pages[currentPageIndex]
        let validator: (String) -> Bool = ValidatorFactory().validator(for: page.validation)
        let isValid = validator(newText)
        return ValidationStatus(bool: isValid, enableButton: isValid, description: "Something is invalid")
    }
    
    func selected(amount: Int) -> ValidationStatus {
        let page = pages[currentPageIndex]
        let validator: (Int) -> Bool = ValidatorFactory().validator(for: page.validation)
        let isValid = validator(amount)
        return ValidationStatus(bool: isValid, enableButton: isValid, description: "Something is invalid")
    }
    
}
