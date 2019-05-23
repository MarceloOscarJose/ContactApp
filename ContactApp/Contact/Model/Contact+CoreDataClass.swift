//
//  Contact+CoreDataClass.swift
//  ContactApp
//
//  Created by Marcelo José on 22/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Contact)
public class Contact: NSManagedObject, Codable {

    public enum ContactCodingKeys: String, CodingKey, CaseIterable {
        case contactID, firstName, lastName, phoneNumber, streetAddress1, streetAddress2,
        city, state, zipCode
    }

    required convenience public init(from decoder: Decoder) throws {
        let entity = Contact(entity: Contact.entity(), insertInto: nil)
        self.init(entity: entity.entity, insertInto: nil)

        let values = try decoder.container(keyedBy: ContactCodingKeys.self)

        for key in values.allKeys {
            switch key {
            case .contactID: contactID = try values.decode(String.self, forKey: .contactID)
            case .firstName: firstName = try values.decode(String.self, forKey: .firstName)
            case .lastName: lastName = try values.decode(String.self, forKey: .lastName)
            case .phoneNumber: phoneNumber = try values.decode(String.self, forKey: .phoneNumber)
            case .streetAddress1: streetAddress1 = try? values.decode(String.self, forKey: .streetAddress1)
            case .streetAddress2: streetAddress2 = try? values.decode(String.self, forKey: .streetAddress2)
            case .city: city = try? values.decode(String.self, forKey: .city)
            case .state: state = try? values.decode(String.self, forKey: .state)
            case .zipCode: zipCode = try? values.decode(String.self, forKey: .zipCode)
            }
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ContactCodingKeys.self)
        for keyName in ContactCodingKeys.allCases {
            switch keyName {
            case .contactID:
                try container.encodeIfPresent(contactID, forKey: .contactID)
            case .firstName:
                try container.encodeIfPresent(firstName, forKey: .firstName)
            case .lastName:
                try container.encodeIfPresent(lastName, forKey: .lastName)
            case .phoneNumber:
                try container.encodeIfPresent(phoneNumber, forKey: .phoneNumber)
            case .streetAddress1:
                try container.encodeIfPresent(streetAddress1, forKey: .streetAddress1)
            case .streetAddress2:
                try container.encodeIfPresent(streetAddress2, forKey: .streetAddress2)
            case .city:
                try container.encodeIfPresent(city, forKey: .city)
            case .state:
                try container.encodeIfPresent(state, forKey: .state)
            case .zipCode:
                try container.encodeIfPresent(zipCode, forKey: .zipCode)
            }
        }
    }
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")!
}
