//
//  EditModel.swift
//  ContactApp
//
//  Created by Marcelo José on 23/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class EditModel: NSObject {

    var editData: [EditData] = [
        EditData(key: "firstName", name: "First name", value: ""),
        EditData(key: "lastName", name: "Last name", value: ""),
        EditData(key: "phoneNumber", name: "Phone", value: ""),
        EditData(key: "streetAddress1", name: "Address line 1", value: ""),
        EditData(key: "streetAddress2", name: "Address line 2", value: ""),
        EditData(key: "city", name: "City", value: ""),
        EditData(key: "state", name: "State", value: ""),
        EditData(key: "zipCode", name: "Zip code", value: "")
    ]

    func parseContactEntity(contact: Contact) -> [EditData] {

        for (index, key) in editData.enumerated() {
            let value = contact.value(forKey: key.key)  as! String
            editData[index].value = value
        }

        return editData
    }
}

struct EditData {
    let key: String
    let name: String
    var value: String
}
