//
//  DetailViewController.swift
//  ContactApp
//
//  Created by Marcelo José on 23/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit
import PXStickyHeaderCollectionView

class DetailViewController: UIViewController, ContactListDelegate {

    // IBOutlets
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    // Collection view
    var containerView: PXStickyHeaderCollectionView!
    let headerView = DetailHeaderView()
    let detailFieldtCellIdentifier = "DetailCollectionViewCell"

    // Data vars
    var delegate: ContactDetailDelegate!
    let model = DetailModel()
    var contactData: Contact!
    var detaildata: [ContactData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControls()
    }

    func setupControls() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editAction))

        containerView = PXStickyHeaderCollectionView(initHeaderHeight: 100, minHeaderHeight: 50, maxHeaderHeight: 150, headerView: headerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(containerView)
        NSLayoutConstraint(item: containerView!, attribute: .top, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: containerView!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: containerView!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: containerView!, attribute: .bottom, relatedBy: .equal, toItem: deleteButton, attribute: .top, multiplier: 1, constant: 0).isActive = true

        containerView.collectionView.register(UINib(nibName: detailFieldtCellIdentifier, bundle: .main), forCellWithReuseIdentifier: detailFieldtCellIdentifier)
        containerView.delegate = self
        containerView.dataSource = self

        reloadDetailView()
    }

    func setContactData(contactData: Contact) {
        self.contactData = contactData
        self.detaildata = model.parseContactEntity(contact: contactData)
    }

    func reloadDetailView() {
        headerView.updateHeader(firstName: contactData.firstName, lastName: contactData.lastName)
        self.containerView.collectionView.reloadData()
    }

    @IBAction func deleteAction(_ sender: Any) {
        let alert = UIAlertController(title: "Delete contact", message: "Are you sure ?", preferredStyle: .alert)

        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            self.model.deleteContact(contact: self.contactData)
            if let delegate = self.delegate {
                delegate.contactDeleted()
            }
        })

        alert.addAction(deleteAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }

    @objc func editAction() {
        let editViewController = EditViewController()
        editViewController.delegate = self
        editViewController.contactData = contactData

        self.navigationController?.pushViewController(editViewController, animated: true)
    }
}

extension DetailViewController: EditViewControllerDelegate {

    func contactSaved(contactData: Contact) {
        setContactData(contactData: contactData)
        reloadDetailView()

        if let delegate = self.delegate {
            delegate.contactUpdated(contactData: contactData)
        }
    }
}

protocol ContactDetailDelegate: class {
    func contactUpdated(contactData: Contact)
    func contactDeleted()
}
