//
//  QuestionViewControllerProtocol.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 18/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import UIKit

class CommonViewController: UIViewController {
    
    let question: Question
    var compilation: AnswerCompilation?
    
    // container view controller references
    var viewModel: ContainerViewModelProtocol
    var nextButton: UIButton
    
    init(question: Question, nibName: String, viewModel: ContainerViewModelProtocol, nextButton: UIButton) {
        self.question = question
        self.viewModel = viewModel
        self.nextButton = nextButton
        super.init(nibName: nibName, bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.isEnabled = false
    }
    
    func updateNextButtonUI(status: ValidationStatus) {
        switch status {
        case .valid(let enable): nextButton.isEnabled = enable
        case .invalid: nextButton.isEnabled = false
        }
    }
}
