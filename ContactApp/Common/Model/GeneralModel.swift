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
        ContactData(key: "firstName", name: "First name", contextType: .name, keyboardType: .alphabet, value: ""),
        ContactData(key: "lastName", name: "Last name", contextType: .name, keyboardType: .alphabet, value: ""),
        ContactData(key: "phoneNumber", name: "Phone", contextType: .telephoneNumber, keyboardType: .phonePad, value: ""),
        ContactData(key: "streetAddress1", name: "Address line 1", contextType: .streetAddressLine1, keyboardType: .asciiCapable, value: ""),
        ContactData(key: "streetAddress2", name: "Address line 2", contextType: .streetAddressLine2, keyboardType: .asciiCapable, value: ""),
        ContactData(key: "city", name: "City", contextType: .addressCity, keyboardType: .asciiCapable, value: ""),
        ContactData(key: "state", name: "State", contextType: .addressState, keyboardType: .asciiCapable, value: ""),
        ContactData(key: "zipCode", name: "Zip code", contextType: .postalCode, keyboardType: .decimalPad, value: "")
    ]
}

struct ContactData {
    let key: String
    let name: String
    let contextType: UITextContentType
    let keyboardType: UIKeyboardType
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
