//
//  DetailViewController.swift
//  ContactApp
//
//  Created by Marcelo José on 23/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var fullNameLabel: UILabel!

    // Data vars
    var contactData: Contact!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControls()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fullNameLabel.text = contactData.firstName
    }

    func setupControls() {
        navigationItem.largeTitleDisplayMode = .never
    }

    func updateDetail(contactData: Contact) {
        self.contactData = contactData
    }
}
