//
//  ContactData.swift
//  ContactApp
//
//  Created by Marcelo José on 23/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import Foundation

struct ContactData: Codable {
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var streetAddress1: String?
    var streetAddress2: String?
    var city: String?
    var state: String?
    var zipCode: String?
}
