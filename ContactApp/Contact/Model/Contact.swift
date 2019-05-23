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

class Contact: NSManagedObject, Codable {

    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else {
            throw ContactDecodeError.contextNotFound
        }

        self.init(entity: Contact(context: context).entity, insertInto: nil)
        let container = try decoder.container(keyedBy: ContactCodingKeys.self)

        for key in container.allKeys {
            switch key {
            case .contactID: contactID = try container.decode(String.self, forKey: .contactID)
            case .firstName: firstName = try container.decode(String.self, forKey: .firstName)
            case .lastName: lastName = try container.decode(String.self, forKey: .lastName)
            case .phoneNumber: phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
            case .streetAddress1: streetAddress1 = try? container.decode(String.self, forKey: .streetAddress1)
            case .streetAddress2: streetAddress2 = try? container.decode(String.self, forKey: .streetAddress2)
            case .city: city = try? container.decode(String.self, forKey: .city)
            case .state: state = try? container.decode(String.self, forKey: .state)
            case .zipCode: zipCode = try? container.decode(String.self, forKey: .zipCode)
            }
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ContactCodingKeys.self)

        for keyName in ContactCodingKeys.allCases {
            switch keyName {
            case .contactID: try container.encodeIfPresent(contactID, forKey: .contactID)
            case .firstName: try container.encodeIfPresent(firstName, forKey: .firstName)
            case .lastName: try container.encodeIfPresent(lastName, forKey: .lastName)
            case .phoneNumber: try container.encodeIfPresent(phoneNumber, forKey: .phoneNumber)
            case .streetAddress1: try container.encodeIfPresent(streetAddress1, forKey: .streetAddress1)
            case .streetAddress2: try container.encodeIfPresent(streetAddress2, forKey: .streetAddress2)
            case .city: try container.encodeIfPresent(city, forKey: .city)
            case .state: try container.encodeIfPresent(state, forKey: .state)
            case .zipCode: try container.encodeIfPresent(zipCode, forKey: .zipCode)
            }
        }
    }
}
