//
//  ContactModel.swift
//  ContactApp
//
//  Created by Marcelo José on 21/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class ContactModel: NSObject {

    let initContactKey = ConfigManager.shared.config.initContacsKey

    func initContacts() -> [[Contact]] {
        if !shouldSaveInitContacts() {
            if let path = Bundle.main.path(forResource: "Contacts", ofType: "json") {
                do {
                    let data: Data = try NSData(contentsOfFile: path as String, options: NSData.ReadingOptions.dataReadingMapped) as Data
                    let decoder = JSONDecoder()
                    decoder.userInfo[.context] = PersistenceManager.shared.persistentContainer.viewContext

                    let contacts = try decoder.decode([Contact].self, from: data)

                    for contact in contacts {
                        saveContact(contact: contact)
                    }

                    changeInitContactsProperty(value: true)
                } catch let error {
                    print(error)
                }
            }
        }

        return getContacts()
    }

    func changeInitContactsProperty(value: Bool) {
        UserDefaults.standard.set(value, forKey: initContactKey)
    }

    func shouldSaveInitContacts() -> Bool {
        return UserDefaults.standard.bool(forKey: initContactKey)
    }

    func deleteContact(contact: Contact) {
        let backgroundContext = PersistenceManager.shared.persistentContainer.newBackgroundContext()

        do {
            if let contactData = PersistenceManager.shared.fetchById(Contact.self, idKey: "contactID", id: contact.contactID) {
                backgroundContext.delete(contactData)
                try backgroundContext.save()
            }
        } catch {
            print(error)
        }
    }

    func saveContact(contact: Contact) {
        let backgroundContext = PersistenceManager.shared.persistentContainer.newBackgroundContext()

        do {
            let newContact = Contact(context: backgroundContext)
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

            try backgroundContext.save()
        } catch {
            print(error)
        }
    }

    func getContacts() -> [[Contact]] {
        var dataModelContacts: [String: [Contact]] = [:]

        if let contacts = PersistenceManager.shared.fetch(Contact.self, sortBy: ["lastName", "firstName"], ascending: true) {
            for contact in contacts {
                if let contactSection = contact.lastName.first {
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
