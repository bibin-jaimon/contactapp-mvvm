//
//  DetailsViewController.swift
//  ContactApp
//
//  Created by Bibin Jaimon on 10/12/20.
//

import UIKit
import MessageUI

protocol DetailsViewControllerDelegate {
    func didTappedDelete(with indexPath: IndexPath)
}

class DetailsViewController: UIViewController {
    var person: Persons?
    var indexPath: IndexPath?
    var delegate: DetailsViewControllerDelegate?
    @IBOutlet weak var detailsTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTappedDeleteButton(_ sender: Any) {
        if let indexPath = self.indexPath {
            delegate?.didTappedDelete(with: indexPath)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func didTappedMailButton(_ sender: Any) {
        guard let email = person?.email else {
            return
        }
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            print("failed sending email")
        }
        
    }

    @IBAction func didTappedCallButton(_ sender: Any) {
        if let phoneNumber = person?.phone {
            print(phoneNumber)
            if let phoneCallURL = URL(string: "telprompt://\(phoneNumber)") {
                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    if #available(iOS 10.0, *) {
                        application.open(phoneCallURL, options: [:], completionHandler: nil)
                    } else {
                        // Fallback on earlier versions
                        application.openURL(phoneCallURL as URL)
                    }
                }
            }
        }
    }
}

extension DetailsViewController :MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PrimaryTableViewCell") as! PrimaryTableViewCell
            cell.setupCell(person: person!)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondaryTableViewCell") as! SecondaryTableViewCell
            cell.setupCell(person: person!, type: SecondaryCellType(rawValue: indexPath.row)!)
            return cell
        }
    }
    
    
}
enum SecondaryCellType: Int {
    case phone = 1
    case email
    case website
    case address
}
