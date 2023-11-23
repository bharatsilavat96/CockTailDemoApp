//
//  IngredientCell.swift
//  Cocktail
//
//  Created by Bharat Silavat on 13/03/23.
//

import UIKit

class IngredientCell: UITableViewCell {

    @IBOutlet weak var ingImgView: UIImageView!
    @IBOutlet weak var ingNameLbl: UILabel!
    @IBOutlet weak var measureLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
