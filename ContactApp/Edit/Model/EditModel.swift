//
//  EditModel.swift
//  ContactApp
//
//  Created by Marcelo José on 23/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class EditModel: GeneralModel {

    func parseContactEntity(contact: Contact) -> [ContactData] {

        for (index, key) in contactDataFields.enumerated() {
            if let value = contact.value(forKey: key.key) as? String {
                contactDataFields[index].value = value
            }
        }

        return contactDataFields
    }

    func saveContact(contact: Contact) {
        let context = PersistenceManager.shared.persistentContainer.viewContext

        do {
            contact.didSave()
            try context.save()
        } catch {
            print(error)
        }
    }
}


