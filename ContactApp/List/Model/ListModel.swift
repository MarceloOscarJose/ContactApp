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

    func initContacts() -> [[Contact]] {
        if !shouldInitilizeContacts() {
            let contacts = ConfigManager.shared.getInitContacts()

            for contact in contacts {
                saveContact(contact: contact)
            }

            changeInitalizedContacts(value: true)
        }

        return getContacts()
    }

    func changeInitalizedContacts(value: Bool) {
        UserDefaults.standard.set(value, forKey: initilizedContactKey)
    }

    func shouldInitilizeContacts() -> Bool {
        return UserDefaults.standard.bool(forKey: initilizedContactKey)
    }

    func saveContact(contact: ContactCodable) {
        let context = PersistenceManager.shared.persistentContainer.viewContext

        do {
            let newContact = Contact(context: context)
            newContact.contactID = UUID().uuidString
            newContact.firstName = contact.firstName
            newContact.lastName = contact.lastName
            newContact.phoneNumber = contact.phoneNumber
            newContact.streetAddress1 = contact.streetAddress1
            newContact.streetAddress2 = contact.streetAddress2
            newContact.state = contact.state
            newContact.city = contact.city
            newContact.zipCode = contact.zipCode
            newContact.didSave()

            try context.save()
        } catch {
            print(error)
        }
    }

    func createNewContact() -> Contact {
        let context = PersistenceManager.shared.persistentContainer.viewContext
        let newContact = Contact(context: context)
        newContact.contactID = UUID().uuidString
        newContact.firstName = ""
        newContact.lastName = ""
        newContact.phoneNumber = ""
        newContact.streetAddress1 = ""
        newContact.streetAddress2 = ""
        newContact.city = ""
        newContact.state = ""
        newContact.zipCode = ""

        return newContact
    }

    func getContacts() -> [[Contact]] {
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
