//
//  ContactListViewController+TableView.swift
//  ContactApp
//
//  Created by Marcelo José on 23/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

extension ListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: contactHeaderCellIdentifier) as! ContactHeaderTableViewCell

        if let sectionData = filteredContactsData[section].first {
            cell.updateCell(sectionTitle: sectionData.lastName.first)
        }

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredContactsData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContactsData[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: contactCellIdentifier, for: indexPath) as! ContactTableViewCell
        let contact = filteredContactsData[indexPath.section][indexPath.item]
        cell.updateCell(firstName: contact.firstName, lastName: contact.lastName)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailViewController = self.delegate as? DetailViewController {
            detailViewController.delegate = self
            splitViewController?.showDetailViewController(detailViewController, sender: nil)
            detailViewController.updateDetail(contactData: filteredContactsData[indexPath.section][indexPath.item])
        }
    }
}
