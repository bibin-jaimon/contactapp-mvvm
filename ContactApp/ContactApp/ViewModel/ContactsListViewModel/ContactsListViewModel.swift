//
//  ContactsListViewModel.swift
//  ContactApp
//
//  Created by Bibin Jaimon on 23/02/21.
//

import Foundation

class ContactsListViewModel: ContactsListViewModelProtocol {
    var groupedContacts: Observable<GroupedContacts> = Observable([])
    var contacts: Observable<[Persons]>?
    
    func insertContactsToCoreData() {
        
    }
    
    func fetchDataFromCoreData() {
        let result = CoreDataManager.shared.fetchAll(from: Persons.self)
        let group = Dictionary(grouping: result) { (contact) -> Character in
            return contact.name!.first!
        }.map { (key: Character, value: [Persons]) -> (letter: Character, contacts: [Persons]) in
            return (letter: key, contacts: value)
        }.sorted { (left, right) -> Bool in
            return left.letter < right.letter
        }
        
        self.groupedContacts.value = group
    }
    
    func getPreprocessedContacts() {
        
    }
    
    
}
