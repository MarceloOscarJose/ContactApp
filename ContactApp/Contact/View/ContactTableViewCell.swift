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

    let firstNameAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 16) as Any]
    let lastNameAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 16) as Any]

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateCell(firstName: String, lastName: String) {
        let finalText = NSMutableAttributedString(string: firstName, attributes: firstNameAttributes)
        finalText.append(NSAttributedString(string: " \(lastName)", attributes: lastNameAttributes))
        contactNameLabel.attributedText = finalText
    }
}
