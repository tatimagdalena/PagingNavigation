//
//  FirstViewController.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 17/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import UIKit

class OneInputViewController: CommonViewController {

    // MARK: Outlets
    
    @IBOutlet var label: UILabel!
    @IBOutlet var textField: UITextField!
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        guard let newText = sender.text else { return }
        handleNewText(newText)
    }
    
    // MARK: - Initializers -

    init(question: Question, viewModel: ContainerViewModelProtocol, nextButton: UIButton) {
        super.init(question: question, nibName: "OneInputViewController", viewModel: viewModel, nextButton: nextButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = question.title
        textField.delegate = self
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
}

extension OneInputViewController: UITextFieldDelegate {
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        let input = Input(id: textField.text ?? "", data: textField.text ?? "")
//        compilation = AnswerCompilation(relatedQuestionId: question.id, inputs: [input])
//    }
    
    func handleNewText(_ newText: String) {
        let input = Input(id: textField.text ?? "", data: textField.text ?? "")
        compilation = AnswerCompilation(relatedQuestionId: question.id, inputs: [input])
        
        let status = viewModel.inputTextChanged(newText: newText)
        updateNextButtonUI(status: status)
    }
    
}
