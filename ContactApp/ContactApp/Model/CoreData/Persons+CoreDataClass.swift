//
//  Persons+CoreDataClass.swift
//  ContactApp
//
//  Created by Bibin Jaimon on 10/12/20.
//
//

import Foundation
import CoreData

@objc(Persons)
public class Persons: NSManagedObject {
    func setValues(from contact: Contact) {
        setValue(contact.name, forKey: #keyPath(Persons.name))
        setValue(contact.city, forKey: #keyPath(Persons.city))
        setValue(contact.email, forKey: #keyPath(Persons.email))
    }
}
