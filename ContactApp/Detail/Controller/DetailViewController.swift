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
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var detailTableView: UITableView!

    let detailFieldtCellIdentifier = "DetailTableViewCell"
    let detailHeaderCellIdentifier = "DetailHeaderTableViewCell"

    var contactData: Contact!
    var detaildata: [DetailData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControls()
    }

    func setupControls() {
        navigationItem.largeTitleDisplayMode = .never
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.rowHeight = 50
        detailTableView.register(UINib(nibName: detailFieldtCellIdentifier, bundle: .main), forCellReuseIdentifier: detailFieldtCellIdentifier)
        detailTableView.register(UINib(nibName: detailHeaderCellIdentifier, bundle: .main), forCellReuseIdentifier: detailHeaderCellIdentifier)
    }

    func updateDetail(contactData: Contact) {
        self.contactData = contactData
        self.detaildata = DetailModel().parseContactEntity(contact: contactData)
        detailTableView.reloadData()
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailHeaderCellIdentifier) as! DetailHeaderTableViewCell
        cell.updateCell(firstName: contactData.firstName, lastName: contactData.lastName)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detaildata.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailFieldtCellIdentifier, for: indexPath) as! DetailTableViewCell
        cell.updateCell(fieldName: detaildata[indexPath.item].name, fieldData: detaildata[indexPath.item].value)
        return cell
    }
}
