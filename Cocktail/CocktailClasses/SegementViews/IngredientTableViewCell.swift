//
//  IngredientTableViewCell.swift
//  Cocktail
//
//  Created by Bharat Silavat on 12/03/23.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ingredientImgView: UIImageView!
    @IBOutlet weak var ingredientNameLbl: UILabel!
    @IBOutlet weak var ingredientQuantityLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
