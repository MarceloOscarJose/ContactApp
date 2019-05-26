//
//  ListViewController.swift
//  ContactApp
//
//  Created by Marcelo José on 21/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, ContactDetailDelegate, EditViewControllerDelegate {

    // IBOutlets
    @IBOutlet weak var contactTableView: UITableView!

    // SearchBar
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = UIColor.lightGray
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.placeholder = "Search by name or phone"
        return searchController
    }()

    // TableView vars
    let contactCellIdentifier = "ContactTableViewCell"
    let contactHeaderCellIdentifier = "ContactHeaderTableViewCell"

    // Data vars
    let model = ListModel()
    var contactsData: [[Contact]] = []
    var filteredContactsData: [[Contact]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupControls()
        getContacts()
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
    }

    func getContacts() {
        contactsData = model.getContacts()
        filteredContactsData = contactsData
        contactTableView.reloadData()
    }

    @objc func hideKeyboard() {
        searchController.searchBar.endEditing(true)
    }

    func contactSaved(contactData: Contact) {
        getContacts()
    }

    func contactUpdated() {
        getContacts()
    }

    @IBAction func addContact(_ sender: Any) {
        let editViewController = EditViewController()
        editViewController.contactData = model.createNewContact()
        editViewController.delegate = self
        self.navigationController?.pushViewController(editViewController, animated: true)
    }

    func showContactDetail(contactData: Contact) {
        let detailViewController = DetailViewController()
        detailViewController.delegate = self
        detailViewController.setContactData(contactData: contactData)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
