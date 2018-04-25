//
//  CPFValidator.swift
//  DataValitation-MVP
//
//  Created by Tatiana Magdalena on 02/02/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation

struct CPFValidator {
    
    private let blacklist = [
        "00000000000",
        "11111111111",
        "22222222222",
        "33333333333",
        "44444444444",
        "55555555555",
        "66666666666",
        "77777777777",
        "88888888888",
        "99999999999",
        "12345678909"
    ]
    
    func validate(document: String) -> Bool {
        
        let unmaskedDocument = document.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "-", with: "")
        
        guard unmaskedDocument.count == 11,
            unmaskedDocument.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil,
            !blacklist.contains(unmaskedDocument)
            else {
                return false
        }
        
        let tenthDigitIndex = unmaskedDocument.index(unmaskedDocument.startIndex, offsetBy: 9)
        let eleventhDigitIndex = unmaskedDocument.index(unmaskedDocument.startIndex, offsetBy: 10)
        
        let d10 = Int(String(unmaskedDocument[tenthDigitIndex]))
        let d11 = Int(String(unmaskedDocument[eleventhDigitIndex]))
        
        var resultModuleOne = 0, resultModuleTwo = 0
        
        for i in 0...8 {
            
            let charIndex = unmaskedDocument.index(unmaskedDocument.startIndex, offsetBy: i)
            let char = Int(String(unmaskedDocument[charIndex]))
            
            resultModuleOne += char! * (10 - i)
            resultModuleTwo += char! * (11 - i)
            
        }
        
        resultModuleOne %= 11
        resultModuleOne = (resultModuleOne < 2) ? 0 : (11 - resultModuleOne)
        
        resultModuleTwo += resultModuleOne * 2
        resultModuleTwo %= 11
        resultModuleTwo = (resultModuleTwo < 2) ? 0 : (11 - resultModuleTwo)
        
        return resultModuleOne == d10 && resultModuleTwo == d11
        
    }
    
}
