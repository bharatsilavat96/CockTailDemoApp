//
//  ListTableViewCell.swift
//  Cocktail
//
//  Created by Bharat Silavat on 13/03/23.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var allNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        allNameLbl.textColor = .random()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
