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

    func changeInitalizedContacts(value: Bool) {
        UserDefaults.standard.set(value, forKey: config.initilizedContactKey)
    }

    func shouldInitilizeContacts() -> Bool {
        return UserDefaults.standard.bool(forKey: config.initilizedContactKey)
    }
}

struct ConfigData: Codable {
    var initilizedContactKey: String
}
