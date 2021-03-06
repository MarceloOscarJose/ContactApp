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

    let phoneAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 14) as Any]
    let phoneBoldAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 14) as Any]

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateCell(firstName: String, lastName: String, phoneNumber: String, searchText: String?) {
        let finalText = NSMutableAttributedString(string: firstName, attributes: firstNameAttributes)
        finalText.append(NSAttributedString(string: " \(lastName)", attributes: lastNameAttributes))

        if let searchText = searchText, phoneNumber.contains(searchText) {
            finalText.append(NSAttributedString(string: "\nPhone number: ", attributes: phoneAttributes))
            finalText.append(searchStringInRange(searchText: searchText, fieldValue: phoneNumber))
        }

        contactNameLabel.attributedText = finalText
    }

    func searchStringInRange(searchText: String, fieldValue: String) -> NSAttributedString {
        let finalString = NSMutableAttributedString(string: fieldValue, attributes: phoneAttributes)

        let range = (fieldValue as NSString).range(of: searchText)
        finalString.setAttributes(phoneBoldAttributes, range: range)

        return finalString
    }
}
