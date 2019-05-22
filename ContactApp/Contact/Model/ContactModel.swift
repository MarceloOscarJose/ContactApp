//
//  ContactModel.swift
//  ContactApp
//
//  Created by Marcelo José on 21/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class ContactModel: NSObject {

    func initContacts() {
        if let path = Bundle.main.path(forResource: "Contacts", ofType: "json") {
            do {
                let data: Data = try NSData(contentsOfFile: path as String, options: NSData.ReadingOptions.dataReadingMapped) as Data
                let contacts = try JSONDecoder().decode([ContactDataModel].self, from: data)
                print(contacts)
            } catch let error {
                print(error)
            }
        }
    }
}
