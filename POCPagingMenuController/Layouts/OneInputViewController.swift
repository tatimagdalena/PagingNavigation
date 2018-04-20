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
    
    // MARK: - Initializers -

    init(output: Output) {
        super.init(output: output, nibName: "OneInputViewController")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = output.title
        textField.delegate = self
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
}

extension OneInputViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        input = Input(relatedOutputId: output.id, id: textField.text ?? "", data: textField.text ?? "")
    }
    
}
