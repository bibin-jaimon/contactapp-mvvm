//
//  ContactsListViewModel.swift
//  ContactApp
//
//  Created by Bibin Jaimon on 23/02/21.
//

import Foundation
import CoreData
import UIKit

class ContactsListViewModel: NSObject,  ContactsListViewModelProtocol {
    func fetchContactsFromServer() {
        NetworkManager.shared.loadContactsToCoreData {[weak self] in
        }
    }
    
    var screenTitle: String {
        return "Contact App"
    }
    
    var hasChangedCoreDaraContent: Observable<Bool> = Observable(false)
    
    func deleteContact(at indexPath: IndexPath) {
        let item = getFetchResultController.object(at: indexPath)
        CoreDataManager.shared.context.delete(item)
        CoreDataManager.shared.saveContext()
    }
    
    var heightForRowAtIndexPath: CGFloat {
        return 70
    }
    
    func itemAtIndexPath(_ indexPath: IndexPath) -> Persons {
        let item = getFetchResultController.object(at: indexPath)
        return item
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        let count = getFetchResultController.sections?[section].numberOfObjects
        return count == nil ? 0 : count!
    }
    
    var numberOfSections: Int {
        let count = getFetchResultController.sections?.count
        return count == nil ? 0 : count!
    }
    
    var getFetchResultController: NSFetchedResultsController<Persons> {
        return self.fetchedResultsController
    }
    
    let cacheName = "Persons"
    var groupedContacts: Observable<GroupedContacts> = Observable([])
    var contacts: Observable<[Persons]>?
    
    lazy var fetchedResultsController: NSFetchedResultsController<Persons> = {
        let fetchRequest: NSFetchRequest<Persons> = Persons.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(Persons.name), ascending: true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                               managedObjectContext: CoreDataManager.shared.context,
                                                               sectionNameKeyPath: #keyPath(Persons.sectionName),
                                                               cacheName: cacheName)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    func insertContactsToCoreData() {
        
    }
    
    func fetchDataFromCoreData() {
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }    
}

extension ContactsListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("reload Tableview")
        hasChangedCoreDaraContent.value = true
    }
}
