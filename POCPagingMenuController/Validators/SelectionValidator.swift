//
//  ValidatorFactory.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 24/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation

struct SelectionValidator {
    
    let min: Int
    let max: Int
    
    func validate(selectionAmount: Int) -> Bool {
        return selectionAmount >= min && selectionAmount <= max
    }
    
}

