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
        ContactData(key: "firstName", name: "First name", contextType: .name, keyboardType: .alphabet, required: true, value: ""),
        ContactData(key: "lastName", name: "Last name", contextType: .name, keyboardType: .alphabet, required: true, value: ""),
        ContactData(key: "phoneNumber", name: "Phone", contextType: .telephoneNumber, keyboardType: .phonePad, required: true, value: ""),
        ContactData(key: "streetAddress1", name: "First Address line", contextType: .streetAddressLine1, keyboardType: .asciiCapable, required: false, value: ""),
        ContactData(key: "streetAddress2", name: "Second Address line", contextType: .streetAddressLine2, keyboardType: .asciiCapable, required: false, value: ""),
        ContactData(key: "city", name: "City", contextType: .addressCity, keyboardType: .asciiCapable, required: false, value: ""),
        ContactData(key: "state", name: "State", contextType: .addressState, keyboardType: .asciiCapable, required: false, value: ""),
        ContactData(key: "zipCode", name: "Zip code", contextType: .postalCode, keyboardType: .decimalPad, required: false, value: "")
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
    let contextType: UITextContentType
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
