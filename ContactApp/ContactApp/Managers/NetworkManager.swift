//
//  NetworkManager.swift
//  ContactApp
//
//  Created by Bibin Jaimon on 10/12/20.
//

import Foundation
import CoreData

class NetworkManager {
    private let BASE_URL = "https://shielded-ridge-19050.herokuapp.com/api/?offset="
    
    public static let shared = NetworkManager()
    
    private init() { }
    
    func loadContactsToCoreData(offset: Int = 0, completion: @escaping ()->Void) {
        if (offset > 19) {return}
        if let path = Bundle.main.path(forResource: "Data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let contacts: [Contact] = try JSONDecoder().decode([Contact].self, from: data)
                CoreDataManager.shared.save(contacts: contacts)
                completion()
            } catch (let error) {
                completion()
                print(error.localizedDescription)
            }
        }
        
        //        URLSession.shared.perform(url: url!, responseModel: [Person].self) { (result) in
        //            switch result {
        //            case .success(let contacts):
        //                contacts.forEach {[weak self] (person) in
        //                    self?.savePerson(person: person)
        //                }
        //                self.save()
        //                self.loadContactsToCoreData(offset: offset + 1)
        //                break
        //            case .failure(let error):
        //                print("error here")
        //                print(error)
        //                break
        //            }
        //        }
    }
}
