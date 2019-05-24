//
//  ConfigManager.swift
//  ContactApp
//
//  Created by Marcelo José on 22/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import Foundation

class ConfigManager: NSObject {
    
    static let shared = ConfigManager()

    // Config vars
    var config: ConfigData!

    override init() {
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist") {
            if let data: NSDictionary = NSDictionary(contentsOfFile: path) {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data as NSDictionary , options: .prettyPrinted)
                    self.config = try JSONDecoder().decode(ConfigData.self, from: jsonData)
                } catch let error {
                    print(error)
                }
            }
        }
    }

    func getInitContacts() -> [ContactCodable] {
        if let path = Bundle.main.path(forResource: "Contacts", ofType: "json") {
            do {
                let data: Data = try NSData(contentsOfFile: path as String, options: NSData.ReadingOptions.dataReadingMapped) as Data
                let contacts = try JSONDecoder().decode([ContactCodable].self, from: data)
                return contacts
            } catch let error {
                print(error)
            }
        }

        return []
    }
}

struct ConfigData: Codable {
    var initilizedContactKey: String
}
