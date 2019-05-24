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
    }

    func updateForm() {
        editData = model.parseContactEntity(contact: contactData)
        editFieldsCollectionView.reloadData()
    }

    @IBAction func saveContact(_ sender: Any) {

        for (index, value) in editData.enumerated() {
            if let fieldValue = getFieldValue(index: index) {
                contactData.setValue(fieldValue, forKey: value.key)
            }
        }

        model.saveContact(contact: contactData)
        updateForm()

        if let delegate = self.delegate {
            delegate.didSaveContact(contactData: contactData)
            self.navigationController?.popViewController(animated: true)
        }
    }

    func getFieldValue(index: Int) -> String? {
        let cell = editFieldsCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) as! EditFieldCollectionViewCell
        return cell.fieldValueTextView.text
    }
}

protocol EditViewControllerDelegate: class {
    func didSaveContact(contactData: Contact)
}
