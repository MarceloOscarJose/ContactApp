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

    func initContacts() -> [[ContactDataModel]] {
        if !shouldSaveInitContacts() {
            changeInitContactsProperty(value: true)
            if let path = Bundle.main.path(forResource: "Contacts", ofType: "json") {
                do {
                    let data: Data = try NSData(contentsOfFile: path as String, options: NSData.ReadingOptions.dataReadingMapped) as Data
                    let contacts = try JSONDecoder().decode([ContactDataModel].self, from: data)

                    for contact in contacts {
                        saveContact(contact: contact)
                    }
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

    func deleteContact(contact: ContactDataModel) {
        let backgroundContext = PersistenceManager.shared.persistentContainer.viewContext

        do {
            if let contactData = PersistenceManager.shared.fetchById(Contact.self, idKey: "contactID", id: contact.contactID) {
                backgroundContext.delete(contactData)
                try backgroundContext.save()
            }
        } catch {
            print(error)
        }
    }

    func saveContact(contact: ContactDataModel) {
        let backgroundContext = PersistenceManager.shared.persistentContainer.viewContext

        let contactId = UUID().uuidString
        do {
            let contactEntity = Contact(context: backgroundContext)
            contactEntity.contactID = contactId
            contactEntity.firstName = contact.firstName
            contactEntity.lastName = contact.lastName
            contactEntity.phoneNumber = contact.phoneNumber
            contactEntity.streetAddress1 = contact.streetAddress1
            contactEntity.streetAddress2 = contact.streetAddress2
            contactEntity.city = contact.city
            contactEntity.state = contact.state
            contactEntity.zipCode = contact.zipCode
            contactEntity.didSave()
            try backgroundContext.save()
        } catch {
            print(error)
        }
    }

    func getContacts() -> [[ContactDataModel]] {
        var dataModelContacts: [String: [ContactDataModel]] = [:]

        if let contacts = PersistenceManager.shared.fetch(Contact.self, sortBy: "lastName", ascending: true) {
            for contact in contacts {
                if let contactlastname = contact.lastName, let contactSection = contactlastname.first {
                    if var keyContacts = dataModelContacts[String(contactSection)] {
                        keyContacts.append(ContactDataModel(contact: contact))
                        dataModelContacts.updateValue(keyContacts, forKey: String(contactSection))
                    } else {
                        dataModelContacts.updateValue([ContactDataModel(contact: contact)], forKey: String(contactSection))
                    }
                }
            }
        }

        let sortedData = dataModelContacts.sorted { (aDic, bDic) -> Bool in
            return aDic.key < bDic.key
        }.compactMap { (key: String, value: [ContactDataModel]) -> [ContactDataModel] in
            return value
        }

        return sortedData
    }
}
