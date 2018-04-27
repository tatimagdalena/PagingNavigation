//
//  QuestionViewControllerProtocol.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 18/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import UIKit

class CommonViewController: UIViewController {
    
    let output: QuestionOutput
    
    var compilation: AnswerCompilation?
    
    // container view controller references
    var viewModel: ContainerViewModelProtocol
    var nextButton: UIButton
    var previousButton: UIButton
    
    init(output: QuestionOutput, nibName: String, viewModel: ContainerViewModelProtocol, nextButton: UIButton, previousButton: UIButton) {
        self.output = output
        self.viewModel = viewModel
        self.nextButton = nextButton
        self.previousButton = previousButton
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
        case .valid(let canMoveForward):
//            nextButton.isEnabled = screenStatus
//            self.screenStatus = screenStatus
            self.nextButton.isEnabled = canMoveForward
        case .invalid:
            nextButton.isEnabled = false
//            self.screenStatus = screenStatus
        }
    }
}
