//
//  DateTextField.swift
//  CustomerRegistration
//
//  Created by Tatiana Magdalena on 11/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import UIKit

protocol DateTextFieldDelegate {
    func dateDidChange(date: Date)
}

@IBDesignable
class DateTextField: UITextField {
    
    @IBInspectable
    var dateFormat: String = "dd MM yyyy" {
        didSet {
            updateDateFormatter(format: dateFormat)
            updateTextFrom(date: datePickerView.date)
        }
    }
    
    var datePickerDelegate: DateTextFieldDelegate?
    
    private let dateFormatter = DateFormatter()
    private let datePickerView = UIDatePicker()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureLayout()
        updateDateFormatter(format: dateFormat)
        addDatePicker()
        updateTextFrom(date: datePickerView.date)
    }
    
    private func configureLayout() {
        layer.cornerRadius = 4.0
        layer.borderWidth = 0.5
    }
    
    private func updateDateFormatter(format: String) {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = dateFormat
    }
    
    private func addDatePicker() {
        datePickerView.datePickerMode = UIDatePickerMode.date
        datePickerView.maximumDate = Date()
        datePickerView.date = Date()
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        inputView = datePickerView
    }
    
    @objc private func datePickerValueChanged(sender: UIDatePicker) {
        updateTextFrom(date: sender.date)
        datePickerDelegate?.dateDidChange(date: sender.date)
    }
    
    func updateTextFrom(date: Date) {
        text = dateFormatter.string(from: date)
    }
}
