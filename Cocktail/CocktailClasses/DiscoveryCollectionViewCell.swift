//
//  DiscoveryCollectionViewCell.swift
//  Cocktail
//
//  Created by Bharat Silavat on 12/03/23.
//

import UIKit

class DiscoveryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionImgView: UIImageView!
    @IBOutlet weak var nameOfDrinkLbl: UILabel!
    
    
    func updateUI(withImgUrl:String, nameOfDrink: String){
        if withImgUrl.isEmpty && nameOfDrink.isEmpty == true {
            self.collectionImgView.image = UIImage(named: "Unknown-2")
            self.nameOfDrinkLbl.text = "No Data Available"
        }else{
            self.nameOfDrinkLbl.text = nameOfDrink
            if let imageUrl = URL(string: withImgUrl) {
                DispatchQueue.global().async {
                    if let imageData = try? Data(contentsOf: imageUrl) {
                        DispatchQueue.main.async {
                            self.collectionImgView.contentMode = .scaleAspectFill
                            self.collectionImgView.image = UIImage(data: imageData)
                        }
                    }
                }
            }
            
        }
    }
}
