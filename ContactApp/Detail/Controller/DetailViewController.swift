//
//  DetailViewController.swift
//  ContactApp
//
//  Created by Marcelo José on 23/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, ContactSelectDelegate {

    // IBOutlets
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var detailTableView: UITableView!

    let detailFieldtCellIdentifier = "DetailTableViewCell"

    var contactData: Contact!
    let model = DetailModel()

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
    }

    func updateDetail(contactData: Contact) {
        fullNameLabel.text = "\(contactData.firstName) \(contactData.lastName)"
        self.contactData = contactData
        detailTableView.reloadData()
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailFieldtCellIdentifier, for: indexPath) as! DetailTableViewCell

        let contact = model.parseContactEntity(contact: contactData)
        cell.updateCell(fieldName: contact[indexPath.item].name, fieldData: contact[indexPath.item].value)
        return cell
    }
}
