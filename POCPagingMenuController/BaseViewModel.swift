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

enum OutputType {
    case singleInput
    case singleSelection(options: [String])
    
    var xibName: String {
        switch self {
        case .singleInput: return "OneInputViewController"
        case .singleSelection: return "SingleSelectionViewController"
        }
    }
}

/// The object that contains all data that is needed to display the view
struct Output {
    let title: String
    let type: OutputType
}

protocol ViewModelProtocol {
    mutating func update(input: Input)
    mutating func getNextOutputs() -> [Output]
}

struct BaseViewModel: ViewModelProtocol {
    
    var currentPage = 0
    var totalPages = 0
    
    private var inputCluster = [Input]()
    private var outputCluster = [Output]()
    
    mutating func update(input: Input) {
        inputCluster.append(input)
    }
    
    mutating func getNextOutputs() -> [Output] {
        let output1 = Output(title: "Single text input", type: .singleInput)
        let output2 = Output(title: "Single selection", type: .singleSelection(options: ["option #1", "option #2"]))
        outputCluster = [output2, output1]
        totalPages = outputCluster.count
        return outputCluster
    }
    
//    enum PagingStatus {
//        case changed(newPage: Int)
//        case reachedEnd(page: Int)
//        case reachedBegining
//    }
//
//    mutating func updateToNextPage() -> PagingStatus {
//        if hasNextPage() {
//            currentPage += 1
//            return .changed(newPage: currentPage)
//        }
//        return .reachedEnd(page: currentPage)
//    }
    
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
