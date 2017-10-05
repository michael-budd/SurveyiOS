//
//  Survey.swift
//  Survey
//
//  Created by Michael Budd on 10/5/17.
//  Copyright © 2017 Michael Budd. All rights reserved.
//

import Foundation

struct Survey {
    
    //MARK: - Keys
    private let nameKey = "name"
    private let emojiKey = "emoji"
    private let uuidKey = "uuid"
    
    //MARK: - Properties
    let identifier: UUID
    let name: String
    let emoji: String
    
    //MARK: - Memberwise init for UUID
    init(name: String, emoji: String, identifier: UUID = UUID()) {
        self.name = name
        self.emoji = emoji
        self.identifier = identifier
    }
    
    //MARK: - Failable
    init?(dictionary: [String: Any], identifier: String) {
        guard let name = dictionary[nameKey] as? String,
            let emoji = dictionary[emojiKey] as? String,
            let identifier = UUID(uuidString: identifier) else { return nil }
        self.name = name
        self.emoji = emoji
        self.identifier = identifier
    }
    
    //MARK: - Dictionary Representation
    var dictionaryRep: [String: Any] {
        let dictionary: [String: Any] = [
            nameKey: name,
            emojiKey: emoji,
            uuidKey: identifier.uuidString
        ]
        return dictionary
    }
    
    //MARK: - Serialize dictionary rep into data
    var jsonData: Data? {
        return try? JSONSerialization.data(withJSONObject: dictionaryRep, options: .prettyPrinted)
    }
    
    //MARK: - RETURN JSON DATA FROM OUR OBJECT
    
    //MARK: - PUT to JSON
    
    
}









