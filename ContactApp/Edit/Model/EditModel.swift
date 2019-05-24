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
        EditData(key: "firstName", name: "First name", contextType: .name, keyboardType: .alphabet, value: ""),
        EditData(key: "lastName", name: "Last name", contextType: .name, keyboardType: .alphabet, value: ""),
        EditData(key: "phoneNumber", name: "Phone", contextType: .telephoneNumber, keyboardType: .phonePad, value: ""),
        EditData(key: "streetAddress1", name: "Address line 1", contextType: .streetAddressLine1, keyboardType: .asciiCapable, value: ""),
        EditData(key: "streetAddress2", name: "Address line 2", contextType: .streetAddressLine2, keyboardType: .asciiCapable, value: ""),
        EditData(key: "city", name: "City", contextType: .addressCity, keyboardType: .asciiCapable, value: ""),
        EditData(key: "state", name: "State", contextType: .addressState, keyboardType: .asciiCapable, value: ""),
        EditData(key: "zipCode", name: "Zip code", contextType: .postalCode, keyboardType: .decimalPad, value: "")
    ]

    func parseContactEntity(contact: Contact) -> [EditData] {

        for (index, key) in editData.enumerated() {
            if let value = contact.value(forKey: key.key) as? String {
                editData[index].value = value
            }
        }

        return editData
    }

    func saveContact(contact: Contact) {
        let context = PersistenceManager.shared.persistentContainer.viewContext

        do {
            contact.didSave()
            try context.save()
        } catch {
            print(error)
        }
    }
}

struct EditData {
    let key: String
    let name: String
    let contextType: UITextContentType
    let keyboardType: UIKeyboardType
    var value: String
}
