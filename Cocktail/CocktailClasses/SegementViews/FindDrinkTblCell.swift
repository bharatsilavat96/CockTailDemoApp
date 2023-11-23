//
//  FindDrinkTblCell.swift
//  Cocktail
//
//  Created by Bharat Silavat on 12/03/23.
//

import UIKit

class FindDrinkTblCell: UITableViewCell {
    
    
    @IBOutlet weak var nameOfIngredient: UILabel!
    @IBOutlet weak var imageOfIngredient: UIImageView!
    
    func updateUI(with data: LDrink?){
        
        if data == nil {
            self.nameOfIngredient.text = "No Ingredient Available"
            self.imageOfIngredient.image = UIImage(named: "img")
        }else {
            self.nameOfIngredient.textColor = .random()
            self.nameOfIngredient.text = data?.strDrink
            if let imageUrl = URL(string: (data?.strDrinkThumb)!) {
                DispatchQueue.global().async {
                    if let imageData = try? Data(contentsOf: imageUrl) {
                        DispatchQueue.main.async {
                            self.imageOfIngredient.layer.borderColor = UIColor.random().cgColor
                            self.imageOfIngredient.image = UIImage(data: imageData)
                        }
                    }
                }
            }
        }
    }
}
