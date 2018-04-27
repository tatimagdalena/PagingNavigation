//
//  OneDateInputViewController.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 27/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import UIKit

class OneDateInputViewController: CommonViewController {

    // MARK: Outlets
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateTextField: DateTextField!
    
    // MARK: - Initializers -
    
    init(output: QuestionOutput, viewModel: ContainerViewModelProtocol, nextButton: UIButton, previousButton: UIButton) {
        super.init(output: output, nibName: "OneDateInputViewController", viewModel: viewModel, nextButton: nextButton, previousButton: previousButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
        
        dateTextField.datePickerDelegate = self
    }

}

extension OneDateInputViewController: DateTextFieldDelegate {
    
    func dateDidChange(date: Date) {
        let input = Input(id: "AOdsojdJIF", data: date)
        compilation = AnswerCompilation(relatedQuestionId: output.id, inputs: [input])
        
//        let status = viewModel.inputDateChanged(newDate: date)
        let status = viewModel.inputChanged(newInput: date)
        
        updateNextButtonUI(status: status)
    }
    
}
