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
        contactsData = model.initContacts()
        filteredContactsData = contactsData
        contactTableView.reloadData()
    }

    @objc func hideKeyboard() {
        searchController.searchBar.endEditing(true)
    }

    func contactUpdated() {
        getContacts()
    }

    func contactDeleted() {
        getContacts()
        self.navigationController?.popViewController(animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addContact" {
            if let editViewController = segue.destination as? EditViewController {
                editViewController.contactData = model.createNewContact()
                editViewController.delegate = self
            }
        }
    }
}

extension ListViewController: EditViewControllerDelegate {

    func didSaveContact(contactData: Contact) {
    }

    func didAddContact() {
        getContacts()
        self.navigationController?.popViewController(animated: true)
    }
}

protocol ContactListDelegate {
    func updateDetail(contactData: Contact)
}
