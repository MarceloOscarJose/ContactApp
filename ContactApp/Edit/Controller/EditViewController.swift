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

    var formFields: [EditFormFieldRow] = []

    // Data vars
    var delegate: EditViewControllerDelegate!
    let editFieldtCellIdentifier = "EditFieldCollectionViewCell"
    let model = EditModel()
    var editData: [ContactData]!
    var contactData: Contact!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControls()
        updateForm()
    }

    func setupControls() {
        navigationItem.largeTitleDisplayMode = .never

        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gesture.cancelsTouchesInView = false
        editFormScrollView.addGestureRecognizer(gesture)

        // Manage keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @IBAction func saveContact(_ sender: Any) {
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
        self.updateForm()

        if let delegate = self.delegate {
            delegate.didSaveContact(contactData: contactData)
        }
    }
}

protocol EditViewControllerDelegate: class {
    func didSaveContact(contactData: Contact)
}
