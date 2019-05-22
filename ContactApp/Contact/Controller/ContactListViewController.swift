//
//  ContactListViewController.swift
//  ContactApp
//
//  Created by Marcelo José on 21/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController {

    let model = ContactModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControls()
    }

    func setupControls() {
        model.initContacts()
    }
}

