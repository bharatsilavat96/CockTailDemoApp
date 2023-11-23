//
//  FindDrinkVC.swift
//  Cocktail
//
//  Created by Bharat Silavat on 12/03/23.
//

import UIKit
import Alamofire

class FindDrinkVC: UIViewController {
    
    @IBOutlet weak var findTableView: UITableView!
    @IBOutlet weak var searchByIngradientView: UIControl!
    @IBOutlet weak var findACocktailView: UIControl!
    @IBOutlet weak var findRandomCocktail: UIControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var ingredientData: DrinkIngredients?
    var GlassData: Glass?
    var alcoholData: Alcahol?
    var selectedButton: Int?
    var allTypeDetail: LatestDrinkOrIngredient?
    var detailInfo: DrinkorBFirstLtrOrRandom?
    @IBOutlet weak var backBtn: UIButton!
    var sectionTitles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addRandomGradient()
        self.showLoading()
        findTableView.dataSource = self
        findTableView.delegate = self
        findTableView.isHidden = true
        searchBar.delegate = self
        searchBar.isHidden = true
        backBtn.isHidden = true
        self.removeLoading()
        
    }
    
    func downloadData(withUrlStr: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: withUrlStr) else {
            completion(nil)
            return
        }
        let request = URLRequest(url: url)
        AF.request(request).responseData { response in
            switch response.result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    @IBAction func backbtnAction(sender: UIButton){
        print("Btn Tapped")
        let vc = storyboard?.instantiateViewController(withIdentifier: "FindDrinkVC") as! FindDrinkVC
        present(vc, animated: true)
    }
    
    @IBAction func returnApiOnSelection(sender: UIControl){
        if sender.tag == 11{
            selectedButton = 11
            self.searchByIngradientView.isHidden = true
            self.findACocktailView.isHidden = true
            self.findRandomCocktail.isHidden = true
            self.showLoading()
            downloadData(withUrlStr: "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list") { data in
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.self.decode(DrinkIngredients.self, from: data!)
                    DispatchQueue.main.async {
                        self.ingredientData = decodedData
                        self.findTableView.isHidden = false
                        self.searchBar.delegate = self
                        self.findTableView.dataSource = self
                        self.findTableView.reloadData()
                    }
                }catch{
                    print("Decoding Ingredinet error ",error.localizedDescription)
                }
            }
            searchBar.isHidden = false
            backBtn.isHidden = false
            self.removeLoading()
            self.findTableView.reloadData()
        }
        if sender.tag == 12{
            selectedButton = 12
            self.searchByIngradientView.isHidden = true
            self.findACocktailView.isHidden = true
            self.findRandomCocktail.isHidden = true
            self.showLoading()
            downloadData(withUrlStr: "https://www.thecocktaildb.com/api/json/v1/1/list.php?g=list") { data in
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.self.decode(Glass.self, from: data!)
                    DispatchQueue.main.async {
                        self.GlassData = decodedData
                        self.findTableView.dataSource = self
                        self.searchBar.delegate = self
                        self.findTableView.reloadData()
                    }
                }catch{
                    print("Decoding Ingredinet error ",error.localizedDescription)
                }
            }
            searchBar.isHidden = false
            self.removeLoading()
            backBtn.isHidden = false
            self.findTableView.reloadData()
            self.findTableView.isHidden = false
        }
        if sender.tag == 13{
            selectedButton = 13
            self.searchByIngradientView.isHidden = true
            self.findACocktailView.isHidden = true
            self.findRandomCocktail.isHidden = true
            self.showLoading()
            downloadData(withUrlStr: "https://www.thecocktaildb.com/api/json/v1/1/list.php?a=list") { data in
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.self.decode(Alcahol.self, from: data!)
                    DispatchQueue.main.async {
                        self.alcoholData = decodedData
                        self.findTableView.dataSource = self
                        self.searchBar.delegate = self
                        self.findTableView.reloadData()
                    }
                }catch{
                    print("Decoding Ingredinet error ",error.localizedDescription)
                }
            }
            searchBar.isHidden = false
            self.removeLoading()
            self.findTableView.reloadData()
            searchBar.delegate = self
            backBtn.isHidden = false
            self.findTableView.isHidden = false
        }
    }
}
extension FindDrinkVC: UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: 0)
        UIView.animate(withDuration: 5, delay: 0.06*Double(indexPath.row), usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2, options: .curveEaseIn, animations: {
            cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: cell.contentView.frame.height)
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedButton {
        case 11:
            return ingredientData?.drinks?.count ?? 0
        case 12:
            return GlassData?.drinks?.count ?? 0
        case 13:
            return alcoholData?.drinks?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
            cell.selectionStyle = .none
            switch selectedButton {
            case 11:
                cell.allNameLbl.text = ingredientData?.drinks?[indexPath.row].strIngredient1 ?? ""
                return cell
            case 12:
                cell.allNameLbl.text = GlassData?.drinks?[indexPath.row].strGlass ?? ""
                return cell
            case 13:
                cell.allNameLbl.text = alcoholData?.drinks?[indexPath.row].strAlcoholic ?? ""
                return cell
            default:
                return cell
            }
        }
}
extension FindDrinkVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        switch selectedButton {
        case 11:
            let data = ingredientData?.drinks?[indexPath.row].strIngredient1 ?? ""
            let encodeData = data.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            print("Cell Clicked ---")
            let api = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=\(encodeData ?? "")"
            print(api)
            downloadData(withUrlStr: api) { data in
                let decoder = JSONDecoder()
                do{
                    let decodedData = try decoder.self.decode(LatestDrinkOrIngredient.self, from: data!)
                    DispatchQueue.main.async {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FindDetailVC") as! FindDetailVC
                        vc.allTypeDetail = decodedData
                        vc.modalPresentationStyle = .fullScreen
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }catch {
                    print("Error in Decoding :",error.localizedDescription)
                }
            }
        case 12:
            let data = GlassData?.drinks?[indexPath.row].strGlass ?? ""
            let encodeData = data.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            print("Cell Clicked---")
            let api = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?g=\(encodeData ?? "")"
            print(api)
            downloadData(withUrlStr: api) { data in
                let decoder = JSONDecoder()
                do{
                    let decodedData = try decoder.self.decode(LatestDrinkOrIngredient.self, from: data!)
                    DispatchQueue.main.async {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FindDetailVC") as! FindDetailVC
                        vc.allTypeDetail = decodedData
                        vc.modalPresentationStyle = .fullScreen
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }catch {
                    print("Error in Decoding :",error.localizedDescription)
                }
            }
        case 13:
            let data = alcoholData?.drinks?[indexPath.row].strAlcoholic ?? ""
            let encodeData = data.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            print("Cell Clicked---")
            let api = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=\(encodeData ?? "")"
            print(api)
            downloadData(withUrlStr: api) { data in
                let decoder = JSONDecoder()
                do{
                    let decodedData = try decoder.self.decode(LatestDrinkOrIngredient.self, from: data!)
                    DispatchQueue.main.async {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FindDetailVC") as! FindDetailVC
                        vc.allTypeDetail = decodedData
                        vc.modalPresentationStyle = .fullScreen
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }catch {
                    print("Error in Decoding :",error.localizedDescription)
                }
            }
        default:
            return
        }
    }
}

extension FindDrinkVC: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        switch selectedButton {
        case 11:
            guard let drinks = ingredientData?.drinks else {return}
            let filteredDrinks = drinks.filter { drink in
                if searchText.isEmpty {
                    return true // show all data
                }
                if let range = drink.strIngredient1!.range(of: searchText, options: .caseInsensitive) {
                    return !range.isEmpty
                }
                return false
            }
            ingredientData?.drinks = filteredDrinks
        case 12:
            guard let drinks = GlassData?.drinks else {return}
            let filteredDrinks = drinks.filter { drink in
                if searchText.isEmpty {
                    return true // show all data
                }
                if let range = drink.strGlass!.range(of: searchText, options: .caseInsensitive) {
                    return !range.isEmpty
                }
                return false
            }
            GlassData?.drinks = filteredDrinks
        case 13:
            guard let drinks = alcoholData?.drinks else {return}
            let filteredDrinks = drinks.filter { drink in
                if searchText.isEmpty {
                    return true // show all data
                }
                if let range = drink.strAlcoholic!.range(of: searchText, options: .caseInsensitive) {
                    return !range.isEmpty
                }
                return false
            }
            alcoholData?.drinks = filteredDrinks
        default:
            return
        }
        findTableView.dataSource = self
        findTableView.reloadData()
    }
//func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//    findTableView.isHidden = false
//    self.findTableView.reloadData()
//    searchByIngradientView.isHidden = true
//    findACocktailView.isHidden = true
//    findRandomCocktail.isHidden = true
//}
//func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
//    return true
//}
//func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//    self.searchBar.isHidden = true
//    self.findTableView.isHidden = false
//    self.searchByIngradientView.isHidden = false
//    self.findACocktailView.isHidden = false
//    self.findRandomCocktail.isHidden = false
//}
}
