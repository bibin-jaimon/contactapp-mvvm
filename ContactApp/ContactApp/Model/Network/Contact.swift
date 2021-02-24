//
//  Person.swift
//  ContactApp
//
//  Created by Bibin Jaimon on 10/12/20.
//

import Foundation

struct Contact: Decodable {
    var name: String
    var phone: String
    var email: String
    
    var company: String
    var street: String
    var city: String
    var zip: Int
    
    var id: Int
    
    var age: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case phone = "Phone"
        case email = "Email"
        case zip = "Zip"
        case company = "Company"
        case street = "Street"
        case city = "City"
        case id = "ID"
        case age = "Age"
    }
}
