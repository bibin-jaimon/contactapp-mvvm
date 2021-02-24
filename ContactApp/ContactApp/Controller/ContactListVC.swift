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
    
    var viewModel: ContactsListViewModelProtocol = ContactsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = self.viewModel.screenTitle
        contactListTV.delegate = self
        contactListTV.dataSource = self
        
        self.viewModel.hasChangedCoreDaraContent.bind { (status) in
            self.contactListTV.reloadData()
        }
        self.viewModel.fetchDataFromCoreData()
        self.viewModel.fetchContactsFromServer()
    }
}
//MARK:-
extension ContactListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: contactCellIdentifier) as! PersonTableViewCell
        let item = self.viewModel.itemAtIndexPath(indexPath)
        cell.setupCell(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.heightForRowAtIndexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.viewModel.getFetchResultController.object(at: indexPath)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"DetailsViewController") as! DetailsViewController
        viewController.person = item
        viewController.indexPath = indexPath
        viewController.delegate = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionInfo = self.viewModel.getFetchResultController.sections?[section]
        return sectionInfo?.name
    }
}
//MARK:-
extension ContactListVC: DetailsViewControllerDelegate {
    func didTappedDelete(with indexPath: IndexPath) {
        self.viewModel.deleteContact(at: indexPath)
    }
}
