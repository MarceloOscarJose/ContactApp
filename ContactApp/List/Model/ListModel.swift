//
//  ListModel.swift
//  ContactApp
//
//  Created by Marcelo José on 21/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import Foundation

class ListModel: GeneralModel {

    let initilizedContactKey = ConfigManager.shared.config.initilizedContactKey

    func initContacts() {
        if !ConfigManager.shared.shouldInitilizeContacts() {
            let contacts = getInitContacts()

            for contact in contacts {
                saveContact(contact: contact)
            }

            ConfigManager.shared.changeInitalizedContacts(value: true)
        }
    }

    func saveContact(contact: ContactCodable) {
        let context = PersistenceManager.shared.container.viewContext

        do {
            let newContact = Contact(context: context)
            let contactData = contact.getEncodeData()

            for contactValues in contactData {
                if let value = contactValues.value as? String {
                    newContact.setValue(value, forKey: contactValues.key)
                }
            }

            newContact.contactID = UUID().uuidString
            newContact.didSave()

            try context.save()
        } catch {
            print(error)
        }
    }

    func createNewContact() -> Contact {
        let context = PersistenceManager.shared.container.viewContext
        let contact = Contact(context: context)

        for attr in Contact.entity().attributesByName {
            contact.setValue("", forKey: attr.key)
        }

        contact.contactID = UUID().uuidString
        return contact
    }

    func getContacts() -> [[Contact]] {
        initContacts()

        var dataModelContacts: [String: [Contact]] = [:]

        if let contacts = PersistenceManager.shared.fetch(Contact.self, sortBy: ["lastName", "firstName"], ascending: true) {
            for contact in contacts {
                if let contactSection = contact.lastName.first?.uppercased() {
                    if var keyContacts = dataModelContacts[String(contactSection)] {
                        keyContacts.append(contact)
                        dataModelContacts.updateValue(keyContacts, forKey: String(contactSection))
                    } else {
                        dataModelContacts.updateValue([contact], forKey: String(contactSection))
                    }
                }
            }
        }

        let sortedData = dataModelContacts.sorted { (aDic, bDic) -> Bool in
            return aDic.key < bDic.key
        }.compactMap { (key: String, value: [Contact]) -> [Contact] in
            return value
        }

        return sortedData
    }
}
