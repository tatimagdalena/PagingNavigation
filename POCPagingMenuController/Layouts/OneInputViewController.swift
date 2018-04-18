//
//  FirstViewController.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 17/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import UIKit

class OneInputViewController: CommonViewController {

    @IBOutlet var label: UILabel!
    @IBOutlet var textField: UITextField!
    
    
//    private var viewModel: ViewModelProtocol
//    
//    init(viewModel: ViewModelProtocol) {
//        self.viewModel = viewModel
//        super.init(nibName: "FirstViewController", bundle: Bundle.main)
//    }
//
    
    var screenTitle: String
    
    init(title: String) {
        self.screenTitle = title
        super.init(nibName: "OneInputViewController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = screenTitle
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }

    
    
}
