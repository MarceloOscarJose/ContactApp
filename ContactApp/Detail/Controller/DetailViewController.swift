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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControls()
    }

    func setupControls() {
        navigationItem.largeTitleDisplayMode = .never
        detailTableView.delegate = self
        detailTableView.dataSource = self
    }

    func updateDetail(contactData: Contact) {
        fullNameLabel.text = "\(contactData.firstName) \(contactData.lastName)"
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
