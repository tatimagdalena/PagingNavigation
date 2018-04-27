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
    
    // MARK: - Data -
    
    func getNextQuestions() -> [QuestionOutput] {
        
        clearCurrentState()
        
        let questionCluster = FakeDataLayer().getQuestionCluster()
        
        var questionsOutputs = [QuestionOutput]()
        for index in questionCluster.indices {
            let question = questionCluster[index]
            let page = Paging.Page(question: question)
            pages.append(page)
            questionsOutputs.append(QuestionOutput(id: question.id, title: question.title, inputLayout: question.type))
        }
        
        return questionsOutputs
    }
    
    func save(compilation: AnswerCompilation) {
        pages[currentPageIndex].answer = compilation
    }
    
    func sendCompilation() {
        print("** SEND INPUTS TO API **")
        
        for page in pages {
            if let compilation = page.answer {
                print("Question: \(compilation.relatedQuestionId)")
                for input in compilation.inputs {
                    print("Answer \(input.id): \(input.data)")
                }
                print("---")
            }
        }
        
    }
    
    private func clearCurrentState() {
        currentPageIndex = 0
        pages = []
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
    
    func inputChanged<T>(newInput: T) -> ValidationStatus {
        let page = pages[currentPageIndex]
        let validator: (T) -> Bool = ValidatorFactory().validator(for: page.question.validation)
        let isValid = validator(newInput)
        pages[currentPageIndex].isReady = page.question.mandatory || isValid
        return ValidationStatus(bool: isValid, invalidDescription: "Something is invalid")
    }
    
    
    func canMoveForward() -> Bool {
        return pages[currentPageIndex].isReady
    }
}
