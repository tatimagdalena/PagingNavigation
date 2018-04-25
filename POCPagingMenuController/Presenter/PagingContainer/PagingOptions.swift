//
//  PagingOptions.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 19/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation
import PagingMenuController

/// The definition of the paging options is needed for the PagingMenuController framework.

struct Paging {
    struct Page {
        var index = 0
        var isMandatory: Bool
        var validation: ValidationKind
    }
    
    enum ChangeStatus {
        case canMoveToNext(newPage: Int)
        case reachedEnd
        case canMoveToPrevious(newPage: Int)
        case reachedBeggining
    }
    
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
