//
//  FakePresenterModels.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 19/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation

/// The object that contains all data gathered by the view
struct Input {
    let relatedOutputId: String
    let id: String
    let data: String
}

/// The object that contains all data that is needed to display the view
struct Output {
    let id: String
    let title: String
    let type: LayoutType

    enum LayoutType {
        case singleInput
        case singleSelection(options: [String])
    }
}
