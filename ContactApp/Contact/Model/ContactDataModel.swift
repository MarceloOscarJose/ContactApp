//
//  ContactDataModel.swift
//  ContactApp
//
//  Created by Marcelo José on 21/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import Foundation

struct ContactDataModel: Codable {
    let contactID: String!
    let firstName: String!
    let lastName: String!
    let phoneNumber: String!
    let streetAddress1: String?
    let streetAddress2: String?
    let city: String?
    let state: String?
    let zipCode: String?

    init(contact: Contact) {
        self.contactID = contact.contactID
        self.firstName = contact.firstName
        self.lastName = contact.lastName
        self.phoneNumber = contact.phoneNumber
        self.streetAddress1 = contact.streetAddress1
        self.streetAddress2 = contact.streetAddress2
        self.city = contact.city
        self.state = contact.state
        self.zipCode = contact.zipCode
    }
}
