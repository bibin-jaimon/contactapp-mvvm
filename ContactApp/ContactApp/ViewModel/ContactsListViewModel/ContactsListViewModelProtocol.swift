//
//  ContactsListViewModelProtocol.swift
//  ContactApp
//
//  Created by Bibin Jaimon on 23/02/21.
//

import Foundation

public typealias GroupedContacts =  [(letter: Character, contacts: [Persons])]

protocol ContactsListViewModelProtocol {
    func insertContactsToCoreData()
    func fetchDataFromCoreData()
    func getPreprocessedContacts()
    var contacts: Observable<[Persons]>? { get }
    var groupedContacts: Observable<GroupedContacts> {get set}
}
