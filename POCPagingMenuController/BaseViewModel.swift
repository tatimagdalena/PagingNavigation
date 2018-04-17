//
//  BaseViewModel.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 17/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation

struct Input {
    
}

struct Output {
    
}

protocol ViewModelProtocol {
    mutating func update(output: Output)
    func getInput() -> Input
}

struct BaseViewModel: ViewModelProtocol {
    
    var inputChunck = [Input]()
    var outputChunck = [Output]()
    
    mutating func update(output: Output) {
        outputChunck.append(output)
    }
    
    func getInput() -> Input {
        
        return Input()
    }
}
