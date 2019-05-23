//
//  DetailModel.swift
//  ContactApp
//
//  Created by Marcelo José on 23/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class DetailModel: NSObject {

    let fieldNames: [Int: (key: String, name: String)] = [
        0: (key: "firstName", name: "First Name"),
        1: (key: "lastName", name: "Last Name"),
        2: (key: "phoneNumber", name: "Phone"),
        3: (key: "streetAddress1", name: "Address line 1"),
        4: (key: "streetAddress2", name: "Address line 2"),
        5: (key: "city", name: "City"),
        6: (key: "state", name: "State"),
        7: (key: "zipCode", name: "Zip code")
    ]

    func parseContactEntity(contact: Contact) -> [(name: String, value: String)] {

        var dataModel: [(name: String, value: String)] = []

        for i in 0...7 {
            guard let key = fieldNames[i] else { return [] }

            let value = contact.value(forKey: key.key)  as! String
            dataModel.append((name: key.name, value: value))
        }

        return dataModel
    }
}
