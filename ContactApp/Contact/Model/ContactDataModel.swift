//
//  ContactDataModel.swift
//  ContactApp
//
//  Created by Marcelo José on 21/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import Foundation

struct ContactDataModel: Codable {
    let firstName: String
    let lastName: String
    let phoneNumber: String
    let streetAddress1: String
    let streetAddress2: String
    let city: String
    let state: String
    let zipCode: String
}
