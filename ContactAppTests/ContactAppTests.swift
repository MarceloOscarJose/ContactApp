//
//  ContactAppTests.swift
//  ContactAppTests
//
//  Created by Marcelo José on 21/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import XCTest
@testable import ContactApp

class ContactAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testListModel() {
        let model = ListModel()
        let detailModel = DetailModel()

        var contactSections = model.getContacts()
        for sections in contactSections {
            for contact in sections {
                detailModel.deleteContact(contact: contact)
            }
        }

        model.changeInitalizedContacts(value: false)
        contactSections = model.initContacts()
        model.changeInitalizedContacts(value: true)
        XCTAssert(contactSections.count == 8)
        XCTAssert(contactSections[2].count == 3)
    }

    func testEditModel() {
        let model = EditModel()
        let detailModel = DetailModel()

        let contact = Contact(context: PersistenceManager.shared.persistentContainer.viewContext)
        contact.contactID = "123"
        contact.firstName = "Tom"
        contact.lastName = "Jackson"
        contact.phoneNumber = "123456"
        model.saveContact(contact: contact)

        if let savedContact = PersistenceManager.shared.fetchById(Contact.self, idKey: "contactID", id: "123") {
            XCTAssert(savedContact.contactID == "123")
            XCTAssert(savedContact.firstName == "Tom")
            XCTAssert(savedContact.lastName == "Jackson")
            XCTAssert(savedContact.phoneNumber == "123456")
            detailModel.deleteContact(contact: savedContact)
        } else {
            XCTAssert(false)
        }
    }
}
