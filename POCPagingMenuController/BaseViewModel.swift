//
//  BaseViewModel.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 17/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation

struct BaseViewModel {
    struct Loop {
        var currentPage = 0
        var totalPages = 0
    }
    
    var currentLoop: Loop!
    
    private var inputCluster = [Input]()
    private var outputCluster = [Output]()
    
    mutating func getNextOutputs() -> [Output] {
        outputCluster = FakeDataLayer().getOutputCluster()
        currentLoop = Loop(currentPage: 0, totalPages: outputCluster.count)
        return outputCluster
    }
    
    enum PageChangeStatus {
        case canMoveToNext(newPage: Int)
        case reachedEnd
        case canMoveToPrevious(newPage: Int)
        case reachedBeggining
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
    
}
