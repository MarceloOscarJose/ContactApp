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
    let editFieldtCellIdentifier = "EditFieldCollectionViewCell"
    let model = EditModel()
    var editData: [EditData]!
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
    }
}

extension EditViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return editData.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: editFieldtCellIdentifier, for: indexPath) as! EditFieldCollectionViewCell
        let data = editData[indexPath.item]
        cell.updateField(fieldName: data.name, fieldValue: data.value, placeHolder: data.placeHolder, contextType: data.contextType, keyboardType: data.keyboardType)
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width
        return CGSize(width: availableWidth, height: 50)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
