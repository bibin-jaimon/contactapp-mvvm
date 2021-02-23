//
//  PrimaryTableViewCell.swift
//  ContactApp
//
//  Created by Bibin Jaimon on 10/12/20.
//

import UIKit

class PrimaryTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var occupation: UILabel!
    @IBOutlet weak var company: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func setupCell(person: Persons) {
        name.text = person.name
        company.text = person.company
    }
}
