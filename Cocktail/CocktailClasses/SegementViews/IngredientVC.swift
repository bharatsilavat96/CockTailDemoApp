//
//  IngredietVC.swift
//  Cocktail
//
//  Created by Bharat Silavat on 12/03/23.
//

import UIKit

class IngredientVC: UIViewController {
    
    @IBOutlet weak var IngredientTableView: UITableView!
    
    var dataSource: Cocktail?
    var ingredientsArray: [String] = []
    var measuresArray : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //        ingredientsArray = convertIng(data: dataSource!)
        //        measuresArray = convertMeasures(data: dataSource!)
        //        IngredientTableView.dataSource = self
        
    }
    func convertIng(data: Cocktail)->[String]{
        var ingArr : [String] = []
        
        let ing = [data.strIngredient1,data.strIngredient2,data.strIngredient3,data.strIngredient4,data.strIngredient5,data.strIngredient6,data.strIngredient7,data.strIngredient8,data.strIngredient9,data.strIngredient10,data.strIngredient11,data.strIngredient12,data.strIngredient13,data.strIngredient14,data.strIngredient15]
        for i in ing{
            if i?.isEmpty == false{
                ingArr.append(i!.description)
            }else {
                print("Index \(i ?? "") is nil")
            }
        }
        
        return ingArr
    }
    func convertMeasures(data: Cocktail)->[String]{
        var measArr : [String] = []
        let meas = [data.strMeasure1,data.strMeasure2,data.strMeasure3,data.strMeasure4,data.strMeasure5,data.strMeasure6,data.strMeasure7,data.strMeasure8,data.strMeasure9,data.strMeasure10,data.strMeasure11,data.strMeasure12,data.strMeasure13,data.strMeasure14,data.strMeasure15]
        for m in meas{
            if m?.isEmpty == false{
                measArr.append(m!.description)
            }else {
                print("Index \(m ?? "") is nil")
            }
        }
        return measArr
    }
    
}

