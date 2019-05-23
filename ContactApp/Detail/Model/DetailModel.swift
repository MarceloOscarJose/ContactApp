//
//  DetailModel.swift
//  ContactApp
//
//  Created by Marcelo José on 23/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class DetailModel: NSObject {

    var detailData: [DetailData] = [
        DetailData(key: "phoneNumber", name: "Phone", value: ""),
        DetailData(key: "streetAddress1", name: "Address line 1", value: ""),
        DetailData(key: "streetAddress2", name: "Address line 2", value: ""),
        DetailData(key: "city", name: "City", value: ""),
        DetailData(key: "state", name: "State", value: ""),
        DetailData(key: "zipCode", name: "Zip code", value: "")
    ]

    func parseContactEntity(contact: Contact) -> [DetailData] {

        for (index, key) in detailData.enumerated() {
            let value = contact.value(forKey: key.key)  as! String
            detailData[index].value = value
        }

        return detailData
    }
}

struct DetailData {
    let key: String
    let name: String
    var value: String
}
