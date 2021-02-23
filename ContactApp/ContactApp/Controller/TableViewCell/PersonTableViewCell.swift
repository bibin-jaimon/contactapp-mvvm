//
//  PersonTableViewCell.swift
//  ContactApp
//
//  Created by Bibin Jaimon on 10/12/20.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func setupCell(with person: Persons) {
        self.nameLabel.text = person.name
        self.placeLabel.text = person.city
    }
}
