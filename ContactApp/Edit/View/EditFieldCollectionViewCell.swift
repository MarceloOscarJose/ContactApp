//
//  EditFieldCollectionViewCell.swift
//  ContactApp
//
//  Created by Marcelo José on 23/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class EditFieldCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var fieldNameLabel: UILabel!
    @IBOutlet weak var fieldValueTextView: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateField(fieldName: String, fieldValue: String, contextType: UITextContentType, keyboardType: UIKeyboardType, required: Bool) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gesture.cancelsTouchesInView = false
        self.addGestureRecognizer(gesture)

        fieldNameLabel.text = "\(fieldName)\(required ? " (*)" : ""):"
        fieldValueTextView.textContentType = contextType
        fieldValueTextView.placeholder = fieldName
        fieldValueTextView.text = fieldValue
        fieldValueTextView.keyboardType = keyboardType
        fieldValueTextView.delegate = self
    }

    @objc func hideKeyboard() {
        fieldValueTextView.resignFirstResponder()
    }
}

extension EditFieldCollectionViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
}
