//
//  ContainerViewModel.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 17/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation

protocol ContainerViewModelProtocol {
    
    mutating func getNextOutputs() -> [Output]
    func hasNextPage() -> Bool
    func hasPreviousPage() -> Bool
    func nextPageIndex() -> ContainerViewModel.PageChangeStatus
    func previousPageIndex() -> ContainerViewModel.PageChangeStatus
    mutating func updateCurrentPage(index: Int)
    mutating func save(input: Input)
    func sendInputs()
    mutating func clearCurrentState()
    
}

struct ContainerViewModel: ContainerViewModelProtocol {
    struct Loop {
        var currentPage = 0
        var totalPages = 0
    }
    
    enum PageChangeStatus {
        case canMoveToNext(newPage: Int)
        case reachedEnd
        case canMoveToPrevious(newPage: Int)
        case reachedBeggining
    }
    
    var currentLoop: Loop!
    
    private var inputCluster = [Input]()
    private var outputCluster = [Output]()
    
    mutating func getNextOutputs() -> [Output] {
        outputCluster = FakeDataLayer().getOutputCluster()
        currentLoop = Loop(currentPage: 0, totalPages: outputCluster.count)
        return outputCluster
    }
    
    func hasNextPage() -> Bool {
        return currentLoop.currentPage < (currentLoop.totalPages - 1)
    }
    
    func hasPreviousPage() -> Bool {
        return currentLoop.currentPage > 0
    }
    
    func nextPageIndex() -> PageChangeStatus {
        if hasNextPage() {
            return .canMoveToNext(newPage: currentLoop.currentPage + 1)
        }
        return .reachedEnd
    }
    
    func previousPageIndex() -> PageChangeStatus {
        if hasPreviousPage() {
            return .canMoveToPrevious(newPage: currentLoop.currentPage - 1)
        }
        return .reachedBeggining
    }
    
    mutating func updateCurrentPage(index: Int) {
        currentLoop.currentPage = index
    }
    
    mutating func save(input: Input) {
        if let index = inputCluster.index(where: { $0.id == input.id }) {
            inputCluster[index] = input
        }
        else {
            inputCluster.append(input)
        }
    }
    
    func sendInputs() {
        print("** SEND INPUTS TO API **")
        print(inputCluster)
    }
    
    mutating func clearCurrentState() {
        currentLoop = nil
        inputCluster = []
        outputCluster = []
    }
    
}
