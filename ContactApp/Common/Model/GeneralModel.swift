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
        ContactData(key: "firstName", name: "First name", keyboardType: .alphabet, dataType: nil, required: true, value: ""),
        ContactData(key: "lastName", name: "Last name", keyboardType: .alphabet, dataType: nil, required: true, value: ""),
        ContactData(key: "phoneNumber", name: "Phone", keyboardType: .phonePad, dataType: .phoneNumber, required: true, value: ""),
        ContactData(key: "streetAddress1", name: "Address line 1", keyboardType: .asciiCapable, dataType: .address, required: false, value: ""),
        ContactData(key: "streetAddress2", name: "Address line 2", keyboardType: .asciiCapable, dataType: .address, required: false, value: ""),
        ContactData(key: "city", name: "City", keyboardType: .asciiCapable, dataType: nil, required: false, value: ""),
        ContactData(key: "state", name: "State", keyboardType: .asciiCapable, dataType: nil, required: false, value: ""),
        ContactData(key: "zipCode", name: "Zip code", keyboardType: .decimalPad, dataType: nil, required: false, value: "")
    ]

    func getInitContacts() -> [ContactCodable] {
        if let path = Bundle.main.path(forResource: "Contacts", ofType: "json") {
            do {
                let data: Data = try NSData(contentsOfFile: path as String, options: NSData.ReadingOptions.dataReadingMapped) as Data
                return try JSONDecoder().decode([ContactCodable].self, from: data)
            } catch let error {
                print(error)
            }
        }

        return []
    }

    func parseContactEntity(contact: Contact) -> [ContactData] {
        for (index, key) in contactDataFields.enumerated() {
            let value = contact.value(forKey: key.key) as! String
            contactDataFields[index].value = value
        }

        return contactDataFields
    }
}

struct ContactData {
    let key: String
    let name: String
    let keyboardType: UIKeyboardType
    let dataType: UIDataDetectorTypes?
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

    func getEncodeData() -> [String: Any] {
        let encoder = JSONEncoder()

        do {
            let jsonData = try? encoder.encode(self)
            let contactObject = try JSONSerialization.jsonObject(with: jsonData!, options: [])
            return contactObject as! [String : Any]
        } catch {
            print(error)
        }

        return [:]
    }
}
