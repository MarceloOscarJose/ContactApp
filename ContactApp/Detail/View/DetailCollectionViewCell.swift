//
//  DetailCollectionViewCell.swift
//  ContactApp
//
//  Created by Marcelo José on 23/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var detailFieldLabel: UILabel!

    let fieldNameAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 16) as Any]
    let fieldDataAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 16) as Any]

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateCell(fieldName: String, fieldData: String) {
        let finalText = NSMutableAttributedString(string: fieldName, attributes: fieldNameAttributes)
        finalText.append(NSAttributedString(string: ": \(fieldData)", attributes: fieldDataAttributes))
        detailFieldLabel.attributedText = finalText
    }
}
