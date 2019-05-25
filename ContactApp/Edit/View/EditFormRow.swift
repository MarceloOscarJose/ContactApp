//
//  EditFormRow.swift
//  ContactApp
//
//  Created by Marcelo José on 24/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class EditFormRow: UIView {

    lazy var rowLabel: UILabel = {
        let rowLabel = UILabel()
        rowLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        rowLabel.numberOfLines = 0
        rowLabel.textColor = UIColor.darkText
        rowLabel.lineBreakMode = .byWordWrapping
        rowLabel.translatesAutoresizingMaskIntoConstraints = false
        return rowLabel
    }()
    lazy var rowTextField: UITextField = {
        let rowTextField = UITextField()
        rowTextField.font = UIFont(name: "HelveticaNeue", size: 15)
        rowTextField.textColor = UIColor.darkText
        rowTextField.borderStyle = .none
        rowTextField.translatesAutoresizingMaskIntoConstraints = false
        return rowTextField
    }()
    lazy var separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor.lightGray
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupControls() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(rowLabel)
        self.addSubview(rowTextField)
        self.addSubview(separator)

        NSLayoutConstraint(item: rowLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: rowLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: rowLabel, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .width, multiplier: 1, constant: 10).isActive = true

        self.layoutSubviews()

        NSLayoutConstraint(item: rowTextField, attribute: .centerY, relatedBy: .equal, toItem: rowLabel, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: rowTextField, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: rowTextField, attribute: .left, relatedBy: .equal, toItem: rowLabel, attribute: .right, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: rowTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 25).isActive = true

        NSLayoutConstraint(item: separator, attribute: .top, relatedBy: .equal, toItem: rowTextField, attribute: .bottom, multiplier: 1, constant: 1).isActive = true
        NSLayoutConstraint(item: separator, attribute: .leading, relatedBy: .equal, toItem: rowTextField, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: separator, attribute: .trailing, relatedBy: .equal, toItem: rowTextField, attribute: .trailing, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: separator, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 1).isActive = true
    }

    func updateRow(fieldName: String, fieldValue: String, contextType: UITextContentType, keyboardType: UIKeyboardType, required: Bool) {
        setupControls()
        rowLabel.text = "\(fieldName)\(required ? " (*)" : ""):"
        rowTextField.textContentType = contextType
        rowTextField.placeholder = fieldName
        rowTextField.text = fieldValue
        rowTextField.keyboardType = keyboardType
        rowTextField.delegate = self
    }
}

extension EditFormRow: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
}
