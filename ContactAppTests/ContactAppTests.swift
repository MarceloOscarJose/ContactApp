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

    func testContactModel() {
        let model = ContactModel()

        var contacts = model.getContacts()
        for contact in contacts {
            model.deleteContact(contact: contact)
        }

        model.changeInitContactsProperty(value: false)
        contacts = model.initContacts()
        model.changeInitContactsProperty(value: true)
        XCTAssert(contacts.count == 10)
    }
}
