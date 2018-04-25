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
    case string(regex: String)
    case singleInput
    case multiInput(min: Int, max: Int)
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
        case .string(let regex):
            return RegexValidator(regex: regex).validate as! ((T) -> Bool)
        case .singleInput:
            return SelectionValidator(min: 1, max: 1).validate as! ((T) -> Bool)
        case .multiInput(let min, let max):
            return SelectionValidator(min: min, max: max).validate as! ((T) -> Bool)
        case .none:
            return alwaysTrue
        }
    }
    
}

//enum ValidationKind<T> {
//
//    case cnpj
//    case cpf
//    case string(regex: String)
//    case singleInput
//    case multiInput(min: Int, max: Int)
//    case none
//
//    var validator: (T) -> Bool {
//        func alwaysTrue(anything: Any? = nil) -> Bool { return true }
//
//        switch self {
//        case .cnpj:
//            return CNPJValidator().validate as! (T) -> Bool
//        case .cpf:
//            return CPFValidator().validate as! (T) -> Bool
//        case .string(let regex):
//            return RegexValidator(regex: regex).validate as! (T) -> Bool
//        case .singleInput:
//            return SelectionValidator(min: 1, max: 1).validate as! (T) -> Bool
//        case .multiInput(let min, let max):
//            return SelectionValidator(min: min, max: max).validate as! (T) -> Bool
//        case .none:
//            return alwaysTrue
//        }
//    }
//}
