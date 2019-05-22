//
//  ContactHeaderTableViewCell.swift
//  ContactApp
//
//  Created by Marcelo José on 22/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class ContactHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var sectionTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateCell(sectionTitle: Character?) {
        if let sectionTitle = sectionTitle {
            sectionTitleLabel.text = String(sectionTitle)
        }
    }
}
