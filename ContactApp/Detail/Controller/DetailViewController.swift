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

    @IBOutlet weak var detailTableView: UITableView!

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
        NSLayoutConstraint(item: containerView!, attribute: .bottom, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0).isActive = true

        containerView.collectionView.register(UINib(nibName: detailFieldtCellIdentifier, bundle: .main), forCellWithReuseIdentifier: detailFieldtCellIdentifier)
    }

    func updateDetail(contactData: Contact) {
        self.contactData = contactData
        self.detaildata = DetailModel().parseContactEntity(contact: contactData)

        headerView.updateHeader(firstName: contactData.firstName, lastName: contactData.lastName)
        containerView.delegate = self
        containerView.dataSource = self
    }
}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detaildata.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailFieldtCellIdentifier, for: indexPath) as! DetailCollectionViewCell
        cell.updateCell(fieldName: detaildata[indexPath.item].name, fieldData: detaildata[indexPath.item].value)
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
