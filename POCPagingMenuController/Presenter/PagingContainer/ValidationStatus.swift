//
//  ValidationStatus.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 24/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation

enum ValidationStatus {
    case valid(canMoveForward: Bool)
    case invalid(description: String)
    
    init(bool: Bool, invalidDescription: String = "") {
        if bool {
            self = .valid(canMoveForward: bool)
        } else {
            self = .invalid(description: invalidDescription)
        }
    }
}
