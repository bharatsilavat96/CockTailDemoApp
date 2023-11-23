//
//  AllDrinkCollectionViewCell.swift
//  Cocktail
//
//  Created by Bharat Silavat on 12/03/23.
//

import UIKit

class AllDrinkCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var drinkImgV: UIImageView!
    @IBOutlet weak var drinkName: UILabel!
    
    func updateUt(withImgUrl: String, andName: String){
        if withImgUrl.isEmpty && andName.isEmpty == true {
            self.drinkImgV.image = UIImage(named: "Unknown-2")
            self.drinkName.text = "No Data Available"
        }else{
            self.drinkName.text = andName
            if let imageUrl = URL(string: withImgUrl) {
                DispatchQueue.global().async {
                    if let imageData = try? Data(contentsOf: imageUrl) {
                        DispatchQueue.main.async {
                            self.drinkImgV.contentMode = .scaleAspectFill
                            self.drinkImgV.image = UIImage(data: imageData)
                        }
                    }
                }
            }
        }
    }
}

