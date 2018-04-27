//
//  ValidationKind.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 25/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation

enum ValidationKind {
    case cnpj
    case cpf
    case email(regex: String)
    case phone(regex: String)
    case string(regex: String)
    case date(after: Date, before: Date)
    case singleChoice
    case multiChoice(min: Int, max: Int)
    case none
}

struct ValidatorFactory {
    
    func validator<T>(for validation: ValidationKind) -> ( (T) -> Bool ) {
        
        func alwaysTrue(anything: Any? = nil) -> Bool { return true }
        
        switch validation {
        case .cnpj:
            return CNPJValidator().validate as! ((T) -> Bool)
        case .cpf:
            return CPFValidator().validate as! ((T) -> Bool)
        case .email(let regex):
            return RegexValidator(regex: regex).validate as! ((T) -> Bool)
        case .phone(let regex):
            return RegexValidator(regex: regex).validate as! ((T) -> Bool)
        case .string(let regex):
            return RegexValidator(regex: regex).validate as! ((T) -> Bool)
        case let .date(after, before):
            return DateValidator(after: after, before: before).validate as! ((T) -> Bool)
        case .singleChoice:
            return SelectionValidator(min: 1, max: 1).validate as! ((T) -> Bool)
        case .multiChoice(let min, let max):
            return SelectionValidator(min: min, max: max).validate as! ((T) -> Bool)
        case .none:
            return alwaysTrue
        }
    }
    
}
