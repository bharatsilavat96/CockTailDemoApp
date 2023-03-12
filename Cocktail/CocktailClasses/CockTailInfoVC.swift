//
//  CockTailInfoVC.swift
//  Cocktail
//
//  Created by Bharat Silavat on 12/03/23.
//

import UIKit

class CockTailInfoVC: UIViewController {
    
    @IBOutlet weak var cockTailImg: UIImageView!
    @IBOutlet weak var cockTailNameLbl: UILabel!
    @IBOutlet weak var typeOfDrinkLbl: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var likeBtn: UIButton!
    
    var data : Cocktail?
    var ingredintVC: IngredientVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view1.backgroundColor = .cyan
        view2.backgroundColor = .red
        view1.alpha = 1
        view2.alpha = 0
        view3.alpha = 0
        assignData(withData: data!)
    }
    
    @IBAction func ingredientSegAction(_ sender: Any) {
        view1.alpha = 1
        view2.alpha = 0
        view3.alpha = 0
    }
    
    @IBAction func instuctionBtnAction(_ sender: Any) {
        
        view1.alpha = 0
        view2.alpha = 1
        view3.alpha = 0
    }
    
    
    @IBAction func reviewBtnAction(_ sender: Any) {
        
        view1.alpha = 0
        view2.alpha = 0
        view3.alpha = 1
    }
    
    func assignData(withData:Cocktail){
        if let url = URL(string:withData.strDrinkThumb!) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.cockTailImg.contentMode = .scaleToFill
                            self.cockTailImg.image = image
                        }
                    }
                } else if let error = error {
                    print("Error downloading image: \(error.localizedDescription)")
                }
            }
            task.resume()
        }
        cockTailNameLbl.text = withData.strDrink
        typeOfDrinkLbl.text = "\(withData.strAlcoholic ). \(withData.strCategory ?? "")/ \(withData.strTags ?? "")/ \(withData.strGlass ?? "")"
    }
    
    @IBAction func goBackBtn(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func likeBtnAction(sender: UIButton){
        likeBtn.isSelected.toggle()
    }
}
