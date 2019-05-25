//
//  EditViewController.swift
//  ContactApp
//
//  Created by Marcelo José on 23/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var editFormScrollView: UIScrollView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!

    // Data vars
    var delegate: EditViewControllerDelegate!
    let model = EditModel()
    var editData: [ContactData]!
    var contactData: Contact!
    var formFields: [EditFormRowView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControls()
    }

    func setupControls() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveContact))

        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gesture.cancelsTouchesInView = false
        editFormScrollView.addGestureRecognizer(gesture)

        // Manage keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        // Create form rows
        setupForm()
    }

    @objc func saveContact() {
        hideKeyboard()

        for (index, value) in editData.enumerated() {
            if let fieldValue = getFieldValue(index: index) {
                if value.required && fieldValue == "" {
                    showFormErrorValidation()
                    return
                }
                contactData.setValue(fieldValue, forKey: value.key)
            }
        }

        self.model.saveContact(contact: contactData)

        if let delegate = self.delegate {
            delegate.contactSaved(contactData: contactData)
        }

        self.navigationController?.popViewController(animated: true)
    }
}

protocol EditViewControllerDelegate: class {
    func contactSaved(contactData: Contact)
}
