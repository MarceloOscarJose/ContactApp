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

    func updateField(fieldName: String, fieldValue: String, placeHolder: String, contextType: UITextContentType, keyboardType: UIKeyboardType) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gesture.cancelsTouchesInView = false
        self.addGestureRecognizer(gesture)

        fieldNameLabel.text = "\(fieldName):"
        fieldValueTextView.textContentType = contextType
        fieldValueTextView.placeholder = placeHolder
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
