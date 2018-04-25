//
//  ValidationStatus.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 24/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation

enum ValidationStatus {
    case valid(enableButton: Bool)
    case invalid(description: String)
    
    init(bool: Bool, enableButton: Bool = false, description: String = "") {
        if bool {
            self = .valid(enableButton: enableButton)
        }
        else {
            self = .invalid(description: description)
        }
    }
    
    var booleanValue: Bool {
        switch self {
        case .valid: return true
        case .invalid: return false
        }
    }
}


