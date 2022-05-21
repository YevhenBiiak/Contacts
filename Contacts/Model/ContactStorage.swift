//
//  ContactStorage.swift
//  Contacts
//
//  Created by Евгений Бияк on 21.05.2022.
//

import Foundation

protocol ContactStorageProtocol {
    func load() -> [ContactProtocol]
    func save(_ contacts: [ContactProtocol])
}

class ContactStorage: ContactStorageProtocol {
    
    private var storage = UserDefaults.standard
    private var storageKey = "contacts"
    
    
    
    func load() -> [ContactProtocol] {
        var contactsFromStorage: [Contact] = []
        let contacts = storage.array(forKey: storageKey) as? [[String: String]] ?? []
        contacts.forEach {
            let (title, phone) = $0.first!
            contactsFromStorage.append(Contact(title: title, phone: phone))
        }
        return contactsFromStorage
    }
    
    func save(_ contacts: [ContactProtocol]) {
        var contactsToStorage: [[String: String]] = []
        for contact in contacts {
            contactsToStorage.append([contact.title: contact.phone])
        }
        storage.set(contactsToStorage, forKey: storageKey)
    }
    
    
}
