//
//  ContactsListViewModelProtocol.swift
//  ContactApp
//
//  Created by Bibin Jaimon on 23/02/21.
//

import Foundation
import CoreData
import UIKit

public typealias GroupedContacts =  [(letter: Character, contacts: [Persons])]

protocol ContactsListViewModelProtocol {
    var numberOfSections            : Int { get }
    var screenTitle                 : String { get }
    var heightForRowAtIndexPath     : CGFloat { get }
    var hasChangedCoreDaraContent   : Observable<Bool> { set get }
    var contacts                    : Observable<[Persons]>? { get }
    var groupedContacts             : Observable<GroupedContacts> { get set }
    var getFetchResultController    : NSFetchedResultsController<Persons> { get }

    func fetchDataFromCoreData()
    func insertContactsToCoreData()
    func deleteContact(at indexPath: IndexPath)
    func numberOfRowsInSection(_ section: Int) -> Int
    func itemAtIndexPath(_ indexPath: IndexPath) ->  Persons
    func fetchContactsFromServer()
    
}
