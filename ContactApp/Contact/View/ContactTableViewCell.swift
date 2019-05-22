//
//  ContactTableViewCell.swift
//  ContactApp
//
//  Created by Marcelo José on 22/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var contactNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateCell(contactName: String) {
        contactNameLabel.text = contactName
    }
}
