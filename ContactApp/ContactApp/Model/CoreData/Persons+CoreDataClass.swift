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
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
            super.init(entity: entity, insertInto: context)
            print("Init called!")
        }
    
    func setValues(from contact: Contact) {
        setValue(contact.name, forKey: #keyPath(Persons.name))
        setValue(contact.city, forKey: #keyPath(Persons.city))
        setValue(contact.email, forKey: #keyPath(Persons.email))
        setValue(String(contact.name.first!), forKey: #keyPath(Persons.sectionName))
    }
}
