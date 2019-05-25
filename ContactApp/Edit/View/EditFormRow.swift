//
//  EditFormRow.swift
//  ContactApp
//
//  Created by Marcelo José on 24/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class EditFormRowView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var rowLabel: UILabel!
    @IBOutlet weak var rowTextField: UITextField!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        self.translatesAutoresizingMaskIntoConstraints = false
        Bundle.main.loadNibNamed("EditFormRowView", owner: self, options: nil)
        setupConstraints()
    }

    func setupConstraints() {
        contentView.frame = self.frame
        self.addSubview(contentView)
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    func updateRow(fieldName: String, fieldValue: String, keyboardType: UIKeyboardType, required: Bool) {
        rowLabel.text = "\(fieldName)\(required ? " (*)" : ""):"
        rowTextField.placeholder = fieldName
        rowTextField.text = fieldValue
        rowTextField.keyboardType = keyboardType
        rowTextField.delegate = self
    }
}

extension EditFormRowView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
}
