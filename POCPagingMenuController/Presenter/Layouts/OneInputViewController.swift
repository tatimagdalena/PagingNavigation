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

    init(output: QuestionOutput, viewModel: ContainerViewModelProtocol, nextButton: UIButton, previousButton: UIButton) {
        super.init(output: output, nibName: "OneInputViewController", viewModel: viewModel, nextButton: nextButton, previousButton: previousButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = output.title
        textField.delegate = self
        setKeyboardType()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
}

extension OneInputViewController: UITextFieldDelegate {
    
    func handleNewText(_ newText: String) {
        let input = Input(id: "OAPZKCLaljlASd", data: textField.text ?? "")
        compilation = AnswerCompilation(relatedQuestionId: output.id, inputs: [input])
        
        let status = viewModel.inputChanged(newInput: newText)
        updateNextButtonUI(status: status)
    }
    
    func setKeyboardType() {
        if case let .singleInput(keyboard) = output.inputLayout {
            switch keyboard {
            case .number: textField.keyboardType = .numberPad
            case .phone: textField.keyboardType = .phonePad
            case .email: textField.keyboardType = .emailAddress
            case .name: textField.keyboardType = .default
            case .default: textField.keyboardType = .default
            }
        }
    }
    
}
