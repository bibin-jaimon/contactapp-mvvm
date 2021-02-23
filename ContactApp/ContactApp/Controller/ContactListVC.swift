//
//  ViewController.swift
//  ContactApp
//
//  Created by Bibin Jaimon on 10/12/20.
//

import UIKit

class ContactListVC: UIViewController {
    private let contactCellIdentifier = "contactCell"
    @IBOutlet weak var contactListTV: UITableView!
    
    var contacts = [Persons]()
    var grouped: GroupedContacts = []
    
    var viewModel: ContactsListViewModelProtocol = ContactsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title="Contact App"
        contactListTV.delegate = self
        contactListTV.dataSource = self
        
        
        
        self.viewModel.groupedContacts.bind({ (group) in
            self.grouped = group
            self.contactListTV.reloadData()
        })
        
        self.viewModel.fetchDataFromCoreData()
        
        
        
        
//        loadDataFromCoreData()
//        getDataFromApi()
        
        
    }
    
    private func getDataFromApi() {
        NetworkManager.shared.loadContactsToCoreData {[weak self] in
            print("Success")
            DispatchQueue.main.async {
                self?.loadDataFromCoreData()
            }
        }
    }
    
    private func loadDataFromCoreData() {
        reloadGrouping()
    }
    
    func reloadGrouping() {
//        let result = CoreDataManager.shared.fetchAll(from: Persons.self)
//        let group = Dictionary(grouping: result) { (contact) -> Character in
//            print(contact.name!.first!)
//            return contact.name!.first!
//        }.map { (key: Character, value: [Persons]) -> (letter: Character, contacts: [Persons]) in
//            return (letter: key, contacts: value)
//        }.sorted { (left, right) -> Bool in
//            return left.letter < right.letter
//        }
        
//        self.grouped = group
        
        
        
//        self.contactListTV.reloadData()
    }
    
}
//MARK:-
extension ContactListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.grouped.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.grouped[section].contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: contactCellIdentifier) as! PersonTableViewCell
        let item = self.grouped[indexPath.section].contacts[indexPath.row]
        cell.setupCell(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.grouped[indexPath.section].contacts[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"DetailsViewController") as! DetailsViewController
        viewController.person = item
        viewController.indexPath = indexPath
        viewController.delegate = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(self.grouped[section].letter)"
    }
}
//MARK:-
extension ContactListVC: DetailsViewControllerDelegate {
    func didTappedDelete(with indexPath: IndexPath) {
        CoreDataManager.shared.delete(item: self.grouped[indexPath.section].contacts[indexPath.row])
        reloadGrouping()
    }
}
