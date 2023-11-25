//
//  DiscoverCategoryTableViewCell.swift
//  Cocktail
//
//  Created by Bharat Silavat on 09/03/23.
//

import UIKit
import Foundation

protocol DiscoverCategoryCollectionViewCellDelegate: AnyObject {
    func didSelect(item: LDrink)
}
class DiscoverCategoryTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    weak var delegate: DiscoverCategoryCollectionViewCellDelegate?
    var collectionData:LatestDrinkOrIngredient?
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    static let reuseIdentifier = "DiscoverCategoryTableViewCell"
    static let reusableIdentiferCollectionView = "DiscoveryCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData?.drinks!.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverCategoryTableViewCell.reusableIdentiferCollectionView, for: indexPath) as! DiscoveryCollectionViewCell
        cell.layer.borderWidth = 1.5
        cell.layer.borderColor = UIColor.random().cgColor
        let imgUrl = collectionData?.drinks![indexPath.row].strDrinkThumb ?? ""
        let nameOfDrink = collectionData?.drinks![indexPath.row].strDrink
        cell.updateUI(withImgUrl: imgUrl, nameOfDrink: nameOfDrink!)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell is Tapped")
        
        if let drinks = collectionData?.drinks {
            delegate?.didSelect(item: drinks[indexPath.item])
        }
    }
}

