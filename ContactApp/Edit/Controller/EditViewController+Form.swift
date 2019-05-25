//
//  EditViewController+Form.swift
//  ContactApp
//
//  Created by Marcelo José on 24/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

extension EditViewController {

    func setupForm() {

        for values in editData {
            let formRow = EditFormRowView()
            formRow.updateRow(fieldName: values.name, fieldValue: values.value, keyboardType: values.keyboardType, required: values.required)
            formStackView.addArrangedSubview(formRow)
            formRow.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
            editFormScrollView.contentInset = .zero
        } else {
            editFormScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

        editFormScrollView.scrollIndicatorInsets = editFormScrollView.contentInset
    }

    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
}
