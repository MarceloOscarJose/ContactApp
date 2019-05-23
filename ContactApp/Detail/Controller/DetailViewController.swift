//
//  DetailViewController.swift
//  ContactApp
//
//  Created by Marcelo José on 23/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit
import PXStickyHeaderCollectionView

class DetailViewController: UIViewController, ContactSelectDelegate {

    // IBOutlets
    var containerView: PXStickyHeaderCollectionView!
    let headerView = DetailHeaderView()

    @IBOutlet weak var deleteButton: UIButton!

    let detailFieldtCellIdentifier = "DetailCollectionViewCell"

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
        self.detaildata = DetailModel().parseContactEntity(contact: contactData)

        headerView.updateHeader(firstName: contactData.firstName, lastName: contactData.lastName)
        containerView.collectionView.reloadData()
    }

    @IBAction func deleteAction(_ sender: Any) {
    }
}
