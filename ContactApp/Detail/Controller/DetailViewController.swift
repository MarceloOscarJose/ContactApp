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

    // Collection view
    var containerView: PXStickyHeaderCollectionView!
    let headerView = DetailHeaderView()
    let detailFieldtCellIdentifier = "DetailCollectionViewCell"

    // Data vars
    var delegate: ContactDetailDelegate!
    let model = DetailModel()
    var contactData: Contact!
    var detaildata: [DetailData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControls()
    }

    func setupControls() {
        navigationItem.largeTitleDisplayMode = .never

        containerView = PXStickyHeaderCollectionView(initHeaderHeight: 100, minHeaderHeight: 50, maxHeaderHeight: 150, headerView: headerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(containerView)
        NSLayoutConstraint(item: containerView!, attribute: .top, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: containerView!, attribute: .left, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: containerView!, attribute: .right, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: containerView!, attribute: .bottom, relatedBy: .equal, toItem: deleteButton, attribute: .top, multiplier: 1, constant: 0).isActive = true

        containerView.collectionView.register(UINib(nibName: detailFieldtCellIdentifier, bundle: .main), forCellWithReuseIdentifier: detailFieldtCellIdentifier)
        containerView.delegate = self
        containerView.dataSource = self
    }

    func updateDetail(contactData: Contact) {
        self.contactData = contactData
        self.detaildata = model.parseContactEntity(contact: contactData)
        headerView.updateHeader(firstName: contactData.firstName, lastName: contactData.lastName)
        self.containerView.collectionView.reloadData()
    }

    @IBAction func deleteAction(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let deleteAction = UIAlertAction(title: "Delete contact", style: .destructive, handler: { action in
            self.model.deleteContact(contact: self.contactData)
            if let delegate = self.delegate {
                delegate.contactDeleted()
            }
        })

        alert.addAction(deleteAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        // Here show constraints issue. It's an iOS bug
        self.present(alert, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editContact" {
            if let editViewController = segue.destination as? EditViewController {
                editViewController.delegate = self
                editViewController.contactData = contactData
            }
        }
    }
}

extension DetailViewController: EditViewControllerDelegate {

    func didSaveContact(contactData: Contact) {
        updateDetail(contactData: contactData)

        if let delegate = self.delegate {
            delegate.contactUpdated()
        }
    }
}

protocol ContactDetailDelegate: class {
    func contactUpdated()
    func contactDeleted()
}
