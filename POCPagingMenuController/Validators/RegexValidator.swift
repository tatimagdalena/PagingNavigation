//
//  Validations.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 24/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation

struct RegexValidator {
    
    let regex: String
    
    func validate(string: String) -> Bool {
        let stringTest = NSPredicate(format:"SELF MATCHES[c] %@", regex)
        return stringTest.evaluate(with: string)
    }
    
}
