//
//  ListViewController+SearchBar.swift
//  ContactApp
//
//  Created by Marcelo José on 23/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

extension ListViewController: UISearchBarDelegate {

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredContactsData = contactsData
        contactTableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            filteredContactsData = contactsData.compactMap { (value: [Contact]) -> [Contact] in
                return value.filter({ (contact) -> Bool in
                    let searchText = searchText.lowercased()
                    return contact.lastName.lowercased().contains(searchText) || contact.firstName.lowercased().contains(searchText)
                })
                }.filter { $0.count > 0 }
        } else {
            filteredContactsData = contactsData
        }

        contactTableView.reloadData()
    }
}
