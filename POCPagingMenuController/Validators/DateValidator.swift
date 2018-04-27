//
//  DateValidator.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 27/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation

struct DateValidator {
    
    let after: Date
    let before: Date
    
    func validate(date: Date) -> Bool {
        let afterResult = Calendar.current.compare(date, to: after, toGranularity: .day)
        let beforeResult = Calendar.current.compare(before, to: date, toGranularity: .day)
        
        if afterResult == ComparisonResult.orderedAscending ||
            beforeResult == ComparisonResult.orderedAscending {
            return false
        }
        return true
    }
    
}
