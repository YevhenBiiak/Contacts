//
//  Contact.swift
//  Contacts
//
//  Created by Евгений Бияк on 19.05.2022.
//

import UIKit


protocol ContactProtocol {
    var title: String { get }
    var phone: String { get }
}


struct Contact: ContactProtocol {
    var title: String
    var phone: String
}
