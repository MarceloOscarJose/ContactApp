//
//  Contact+Property.swift
//  ContactApp
//
//  Created by Marcelo José on 23/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import Foundation
import CoreData

extension Contact {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var contactID: String
    @NSManaged public var firstName: String
    @NSManaged public var lastName: String
    @NSManaged public var phoneNumber: String
    @NSManaged public var streetAddress1: String?
    @NSManaged public var streetAddress2: String?
    @NSManaged public var city: String?
    @NSManaged public var state: String?
    @NSManaged public var zipCode: String?

    public enum ContactCodingKeys: String, CodingKey, CaseIterable {
        case contactID, firstName, lastName, phoneNumber, streetAddress1, streetAddress2, city, state, zipCode
    }

    enum ContactDecodeError: Error {
        case contextNotFound
    }
}

// MARK: Entity context
extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")!
}