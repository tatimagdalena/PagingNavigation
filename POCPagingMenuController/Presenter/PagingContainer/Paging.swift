//
//  PagingOptions.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 19/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation
import PagingMenuController

struct Paging {
    struct Page {
        var question: Question
        var answer: AnswerCompilation?
        var isReady: Bool
        
        init(question: Question) {
            self.question = question
            isReady = !question.mandatory
        }
    }
    
    enum ChangeStatus {
        case canMoveToNext(newPage: Int)
        case reachedEnd
        case canMoveToPrevious(newPage: Int)
        case reachedBeggining
    }
    
    /// The definition of the paging options is needed for the PagingMenuController framework.
    struct Options: PagingMenuControllerCustomizable {
        var componentType: ComponentType {
            return ComponentType.pagingController(pagingControllers: questionViewControllers)
        }
        
        var isScrollEnabled: Bool {
            return false
        }
        
        var questionViewControllers: [CommonViewController]
        
        init(viewControllers: [CommonViewController]) {
            self.questionViewControllers = viewControllers
        }
    }
}
