//
//  GeneralModel.swift
//  ContactApp
//
//  Created by Marcelo José on 24/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class GeneralModel: NSObject {

    var contactDataFields: [ContactData] = [
        ContactData(key: "firstName", name: "First name", keyboardType: .alphabet, required: true, value: ""),
        ContactData(key: "lastName", name: "Last name", keyboardType: .alphabet, required: true, value: ""),
        ContactData(key: "phoneNumber", name: "Phone", keyboardType: .phonePad, required: true, value: ""),
        ContactData(key: "streetAddress1", name: "Address line 1", keyboardType: .asciiCapable, required: false, value: ""),
        ContactData(key: "streetAddress2", name: "Address line 2", keyboardType: .asciiCapable, required: false, value: ""),
        ContactData(key: "city", name: "City", keyboardType: .asciiCapable, required: false, value: ""),
        ContactData(key: "state", name: "State", keyboardType: .asciiCapable, required: false, value: ""),
        ContactData(key: "zipCode", name: "Zip code", keyboardType: .decimalPad, required: false, value: "")
    ]

    func getInitContacts() -> [ContactCodable] {
        if let path = Bundle.main.path(forResource: "Contacts", ofType: "json") {
            do {
                let data: Data = try NSData(contentsOfFile: path as String, options: NSData.ReadingOptions.dataReadingMapped) as Data
                let contacts = try JSONDecoder().decode([ContactCodable].self, from: data)
                return contacts
            } catch let error {
                print(error)
            }
        }

        return []
    }
}

struct ContactData {
    let key: String
    let name: String
    let keyboardType: UIKeyboardType
    let required: Bool
    var value: String
}

struct ContactCodable: Codable {
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var streetAddress1: String
    var streetAddress2: String
    var city: String?
    var state: String?
    var zipCode: String?
}
