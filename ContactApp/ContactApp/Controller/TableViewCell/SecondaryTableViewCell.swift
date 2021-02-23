//
//  SecondaryTableViewCell.swift
//  ContactApp
//
//  Created by Bibin Jaimon on 10/12/20.
//

import UIKit

class SecondaryTableViewCell: UITableViewCell {

    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(person: Persons, type: SecondaryCellType) {
        switch type {
        case .address:
            titlelabel.text = "Address"
            secondLabel.text = "\(person.street ?? "") \(person.city ?? "")"
        case .email:
            titlelabel.text = "Email"
            secondLabel.text = person.email
        case .phone:
            titlelabel.text = "Phone"
            secondLabel.text = person.phone
        case .website:
            titlelabel.text = "Website"
            
        }
    }
}
