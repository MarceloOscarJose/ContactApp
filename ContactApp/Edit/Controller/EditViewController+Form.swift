//
//  EditViewController+CollectionView.swift
//  ContactApp
//
//  Created by Marcelo José on 24/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

extension EditViewController {
    func updateForm() {
        editData = model.parseContactEntity(contact: contactData)
        var lastElement: UIView = editFormScrollView

        for values in editData {
            let row = EditFormFieldRow()
            editFormScrollView.addSubview(row)

            let top: NSLayoutConstraint.Attribute = lastElement == editFormScrollView ? .top : .bottom
            NSLayoutConstraint(item: row, attribute: .top, relatedBy: .equal, toItem: lastElement, attribute: top, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: row, attribute: .leading, relatedBy: .equal, toItem: editFormScrollView, attribute: .leading, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: row, attribute: .width, relatedBy: .equal, toItem: editFormScrollView, attribute: .width, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: row, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50).isActive = true

            lastElement = row
            row.updateField(fieldName: values.name, fieldValue: values.value, contextType: values.contextType, keyboardType: values.keyboardType, required: values.required)
            formFields.append(row)
        }
    }

    func showFormErrorValidation() {
        let alert = UIAlertController(title: "Error", message: "You should complete all required fields", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

    func getFieldValue(index: Int) -> String? {
        return formFields[index].rowTextField.text
    }

    @objc func handleKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            bottomConstraint.constant = 1
        } else {
            bottomConstraint.constant = keyboardViewEndFrame.height - view.safeAreaInsets.bottom
        }
    }

    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
}
