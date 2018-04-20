//
//  QuestionViewControllerProtocol.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 18/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import UIKit

//protocol CommonViewControllerProtocol {
//
//}

class CommonViewController: UIViewController {
    
//    let layoutType: Output.LayoutType
    
    let output: Output
    var input: Input?
    
//    init(layoutType: Output.LayoutType, nibName: String) {
//        self.layoutType = layoutType
//        super.init(nibName: nibName, bundle: Bundle.main)
//    }
    
    init(output: Output, nibName: String) {
        self.output = output
        super.init(nibName: nibName, bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
