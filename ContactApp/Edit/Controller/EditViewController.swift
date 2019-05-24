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
    @IBOutlet weak var editFieldsCollectionView: UICollectionView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
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
        editFieldsCollectionView.delegate = self
        editFieldsCollectionView.dataSource = self
        editFieldsCollectionView.register(UINib(nibName: editFieldtCellIdentifier, bundle: .main), forCellWithReuseIdentifier: editFieldtCellIdentifier)

        // Manage keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    func updateForm() {
        editData = model.parseContactEntity(contact: contactData)
        editFieldsCollectionView.reloadData()
    }

    @IBAction func saveContact(_ sender: Any) {

        self.view.endEditing(true)

        DispatchQueue.main.async {
            self.performSave()
        }
    }

    func performSave() {
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
            self.navigationController?.popViewController(animated: true)
        }
    }

    func showFormErrorValidation() {
        let alert = UIAlertController(title: "Error", message: "You should complete all required fields", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

    func getFieldValue(index: Int) -> String? {
        let cell = editFieldsCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) as! EditFieldCollectionViewCell
        return cell.fieldValueTextView.text
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
}

protocol EditViewControllerDelegate: class {
    func didSaveContact(contactData: Contact)
}
