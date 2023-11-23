//
//  AllDrinksVC.swift
//  Cocktail
//
//  Created by Bharat Silavat on 12/03/23.
//

import UIKit
import Alamofire

class AllDrinksVC: UIViewController {
    
    @IBOutlet weak var allDrinkCollectionView: UICollectionView!
    
    var cockTails: [LatestDrinkOrIngredient] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allDrinkCollectionView.dataSource = self
        allDrinkCollectionView.delegate = self
        self.view.backgroundColor = .systemPink
    }

    @IBAction func goBack(sender: UIBarButtonItem){
        self.dismiss(animated: true)
    }
}
extension AllDrinksVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cockTails.reduce(0) { count, cocktail in
            return count + (cocktail.drinks?.count ?? 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllDrinkCollectionViewCell", for: indexPath) as! AllDrinkCollectionViewCell
        var drinkName = ""
        var drinkImgUrl = ""
        var drinkIndex = indexPath.row
        for cocktail in cockTails {
            if let drinks = cocktail.drinks, drinkIndex < drinks.count {
                drinkName = drinks[drinkIndex].strDrink ?? ""
                drinkImgUrl = drinks[drinkIndex].strDrinkThumb ?? ""
                break
            } else {
                drinkIndex -= (cocktail.drinks?.count ?? 0)
            }
        }
        
        cell.updateUt(withImgUrl: drinkImgUrl, andName: drinkName)
        return cell
    }
}
extension AllDrinksVC: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = cockTails[indexPath.section].drinks?[indexPath.row].strDrink ?? ""
        let nextApi = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(data)"
        let encodeUrl = nextApi.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: encodeUrl ?? "")
        let urlRequest = URLRequest(url: url!)
        AF.request(urlRequest).response{ response in
            switch response.result{
            case .success(let data):
                  let decoder = JSONDecoder()
                do{
                    let decodedData = try decoder.self.decode(DrinkorBFirstLtrOrRandom.self, from: data!)
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "CockTailInfoVC") as! CockTailInfoVC
                    vc.data = decodedData.drinks[indexPath.row]
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                }catch{
                    print("Error is Decoding:",error.localizedDescription)
                }
            case .failure(let error):
                print("Error",error.localizedDescription)
            }
        }
    }
}
extension AllDrinksVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.width/2-16, height: 200)
    }
}
