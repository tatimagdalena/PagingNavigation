//
//  BaseViewModel.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 17/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation


/// The object that contains all data gathered by the view
struct Input {
    
}


/// The object that contains all data that is needed to display the view
struct Output {
    
}

protocol ViewModelProtocol {
    mutating func update(input: Input)
    mutating func getOutputs() -> [Output]
}

struct BaseViewModel: ViewModelProtocol {
    
    private var inputCluster = [Input]()
    private var outputCluster = [Output]()
    
    mutating func update(input: Input) {
        inputCluster.append(input)
    }
    
    mutating func getOutputs() -> [Output] {
        outputCluster = [Output]()
        return outputCluster
    }
    
    
}
