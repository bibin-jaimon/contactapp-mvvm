//
//  Persons+CoreDataProperties.swift
//  ContactApp
//
//  Created by Bibin Jaimon on 23/02/21.
//
//

import Foundation
import CoreData


extension Persons {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Persons> {
        return NSFetchRequest<Persons>(entityName: "Persons")
    }

    @NSManaged public var age: Int16
    @NSManaged public var city: String?
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: Double
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var street: String?
    @NSManaged public var zip: Double
    @NSManaged public var sectionName: String?

}

extension Persons : Identifiable {

}
