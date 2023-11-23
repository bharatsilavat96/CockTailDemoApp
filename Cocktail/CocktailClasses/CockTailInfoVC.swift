//
//  CockTailInfoVC.swift
//  Cocktail
//
//  Created by Bharat Silavat on 12/03/23.
//

import UIKit
import Alamofire

class CockTailInfoVC: UIViewController {
    
    @IBOutlet weak var cockTailImg: UIImageView!
    @IBOutlet weak var cockTailNameLbl: UILabel!
    @IBOutlet weak var typeOfDrinkLbl: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var instructionTxtView: UITextView!
    @IBOutlet weak var cockTailTableView: UITableView!
    
    var data : Cocktail?
    var urlTypeString: String?
    var ingredientsArray: [String] = []
    var measuresArray : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view1.alpha = 1
        view2.alpha = 0
        view3.alpha = 0
        cockTailTableView.dataSource = self
        print("Current Url is : \(urlTypeString ?? "")")
        if data != nil {
            assignData(withData: data!)
            ingredientsArray = convertIng(data: data!)
            measuresArray = convertMeasures(data: data!)
        } else {
            self.showLoading()
            downloadData(withStringUrl: urlTypeString ?? "")
            ingredientsArray = convertIng(data: data)
            measuresArray = convertMeasures(data: data)
            self.removeLoading()
        }
    }
    func downloadData(withStringUrl: String){
        let url = URL(string: withStringUrl)
        let urlRequest = URLRequest(url: url!)
        AF.request(urlRequest).response{ response in
            switch response.result{
            case .success(let data):
                let decoder = JSONDecoder()
                do{
                    let decodedData = try decoder.self.decode(DrinkorBFirstLtrOrRandom.self, from: data!)
                    DispatchQueue.main.async {
                        self.data = decodedData.drinks[0]
                        self.assignData(withData: self.data!)
                        self.cockTailTableView.reloadData()
                        self.instructionTxtView.text = decodedData.drinks[0].strInstructions ?? ""
                    }
                }catch{
                    print("Error is Decoding:",error.localizedDescription)
                }
            case .failure(let error):
                print("Error",error.localizedDescription)
            }
        }
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
        if let url = URL(string:withData.strDrinkThumb ?? "") {
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
        typeOfDrinkLbl.text = "\(withData.strAlcoholic). \(withData.strCategory ?? "")/ \(withData.strTags ?? "")/ \(withData.strGlass ?? "")"
    }
    @IBAction func goBackBtn(sender: UIButton){
        print("Back Btn Tapped")
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true)
    }
    @IBAction func likeBtnAction(sender: UIButton){
        likeBtn.isSelected.toggle()
    }
}
extension CockTailInfoVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let newData = ingredientsArray.count
        return newData
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as! IngredientCell
        cell.ingNameLbl.text = ingredientsArray[indexPath.row]
        cell.measureLbl.text = measuresArray[indexPath.row]
        return cell
    }
}
extension CockTailInfoVC{
    
    func convertIng(data: Cocktail?)->[String]{
        var ingArr : [String] = []
        
        let ing = [data?.strIngredient1,data?.strIngredient2,data?.strIngredient3,data?.strIngredient4,data?.strIngredient5,data?.strIngredient6,data?.strIngredient7,data?.strIngredient8,data?.strIngredient9,data?.strIngredient10,data?.strIngredient11,data?.strIngredient12,data?.strIngredient13,data?.strIngredient14,data?.strIngredient15]
        for i in ing{
            if i?.isEmpty == false{
                ingArr.append(i!.description)
            }else {
                print("Index \(i ?? "") is nil")
            }
        }
        
        return ingArr
    }
    func convertMeasures(data: Cocktail?)->[String]{
        var measArr : [String] = []
        let meas = [data?.strMeasure1,data?.strMeasure2,data?.strMeasure3,data?.strMeasure4,data?.strMeasure5,data?.strMeasure6,data?.strMeasure7,data?.strMeasure8,data?.strMeasure9,data?.strMeasure10,data?.strMeasure11,data?.strMeasure12,data?.strMeasure13,data?.strMeasure14,data?.strMeasure15]
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

