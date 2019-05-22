//
//  ContactListViewController.swift
//  ContactApp
//
//  Created by Marcelo José on 21/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var contactTableView: UITableView!

    // SearchBar
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.scopeButtonTitles = ConfigManager.shared.config.contactListScopes
        searchController.searchBar.tintColor = UIColor.ligthBlue
        searchController.searchBar.showsScopeBar = true
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.placeholder = "Search contacts"
        return searchController
    }()

    // TableView vars
    let contactCellIdentifier = "ContactTableViewCell"
    let contactHeaderCellIdentifier = "ContactHeaderTableViewCell"

    // Data vars
    let model = ContactModel()
    var contactsData: [[ContactDataModel]] = []
    var filteredContactsData: [[ContactDataModel]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupControls()
    }

    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.searchBar.delegate = self
    }

    func setupControls() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gesture.cancelsTouchesInView = false

        contactTableView.delegate = self
        contactTableView.dataSource = self
        contactTableView.rowHeight = 50
        contactTableView.addGestureRecognizer(gesture)
        contactTableView.register(UINib(nibName: contactCellIdentifier, bundle: .main), forCellReuseIdentifier: contactCellIdentifier)
        contactTableView.register(UINib(nibName: contactHeaderCellIdentifier, bundle: .main), forCellReuseIdentifier: contactHeaderCellIdentifier)
        contactsData = model.initContacts()
        filteredContactsData = contactsData
    }

    @objc func hideKeyboard() {
        searchController.searchBar.endEditing(true)
    }
}

extension ContactListViewController: UITableViewDelegate, UITableViewDataSource {

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
}

extension ContactListViewController: UISearchBarDelegate {

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredContactsData = contactsData
        contactTableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            filteredContactsData = contactsData.compactMap { (value: [ContactDataModel]) -> [ContactDataModel] in
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
