//
//  CoreDataManager.swift
//  ContactApp
//
//  Created by Bibin Jaimon on 10/12/20.
//

import Foundation
import CoreData

class CoreDataManager {
    private init() {
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    public static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ContactApp")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private func performFetch<T: NSManagedObject>(fetchRequest: NSFetchRequest<NSFetchRequestResult>) -> [T] {
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        } catch {
            print(error)
            return [T]()
        }
    }
    
    func delete<T: NSManagedObject>(item: T) {
        context.delete(item)
        saveContext()
    }
    
    private func getFetchRequestEntity<T: NSManagedObject>(describing objectType: T.Type) ->
    NSFetchRequest<NSFetchRequestResult> {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        return fetchRequest
    }
    
    func fetchAll<T: NSManagedObject>(from entity: T.Type) -> [T] {
        let fetchRequest = getFetchRequestEntity(describing: entity)
        let sortDescriptors = NSSortDescriptor(key: #keyPath(Persons.name), ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptors]
        let result = performFetch(fetchRequest: fetchRequest) as! [T]
        return result
    }
    
    func fetch<T: NSManagedObject>(from entity: T.Type, withID: Int) {
        
    }
}
//MARK:-
extension CoreDataManager {
    func save(contacts: [Contact]) {
        _ = contacts.map { (contact) in
            let person = Persons(context: context)
            person.setValues(from: contact)
        }
        self.saveContext()
    }
}
