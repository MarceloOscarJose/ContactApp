//
//  ListViewController.swift
//  ContactApp
//
//  Created by Marcelo José on 21/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, ContactDetailDelegate {

    // IBOutlets
    @IBOutlet weak var contactTableView: UITableView!

    // SearchBar
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = UIColor.ligthBlue
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.placeholder = "Search contacts"
        return searchController
    }()

    // TableView vars
    let contactCellIdentifier = "ContactTableViewCell"
    let contactHeaderCellIdentifier = "ContactHeaderTableViewCell"

    // Data vars
    var delegate: ContactListDelegate!
    let model = ListModel()
    var contactsData: [[Contact]] = []
    var filteredContactsData: [[Contact]] = []

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

        definesPresentationContext = true
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

    func contactDeleted() {
        contactsData = model.initContacts()
        filteredContactsData = contactsData
        contactTableView.reloadData()
    }
}

protocol ContactListDelegate {
    func updateDetail(contactData: Contact)
}
