//
//  DetailModel.swift
//  ContactApp
//
//  Created by Marcelo José on 23/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class DetailModel: GeneralModel {

    func parseContactEntity(contact: Contact) -> [ContactData] {

        for (index, key) in contactDataFields.enumerated() {
            let value = contact.value(forKey: key.key) as! String
            contactDataFields[index].value = value
        }

        return contactDataFields
    }

    func deleteContact(contact: Contact) {
        let context = PersistenceManager.shared.persistentContainer.viewContext

        do {
            if let contactData = PersistenceManager.shared.fetchById(Contact.self, idKey: "contactID", id: contact.contactID) {
                context.delete(contactData)
                try context.save()
            }
        } catch {
            print(error)
        }
    }
}
