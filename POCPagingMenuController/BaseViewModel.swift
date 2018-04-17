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
    
    var currentPage = 0
    var totalPages = 2
    
    private var inputCluster = [Input]()
    private var outputCluster = [Output]()
    
    mutating func update(input: Input) {
        inputCluster.append(input)
    }
    
    mutating func getOutputs() -> [Output] {
        outputCluster = [Output]()
        return outputCluster
    }
    
    func hasNextPage() -> Bool {
        return currentPage < (totalPages - 1)
    }
    
    mutating func updateCurrentPage(index: Int) {
        currentPage = index
    }
    
    func hasPreviousPage() -> Bool {
        return currentPage > 0
    }
    
    func outputFor(page: Int) -> Output {
        return outputCluster[page]
    }
    
}
