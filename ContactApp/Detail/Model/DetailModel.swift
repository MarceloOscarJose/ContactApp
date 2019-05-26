//
//  DetailModel.swift
//  ContactApp
//
//  Created by Marcelo José on 23/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class DetailModel: GeneralModel {

    func deleteContact(contact: Contact) {
        let context = PersistenceManager.shared.container.viewContext

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
