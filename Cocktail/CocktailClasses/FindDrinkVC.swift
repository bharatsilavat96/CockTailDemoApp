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
    
    var dataToSend: Cocktail?
    var filteredData: [Cocktail]?
    var findIngradientArray : DrinkorBFirstLtrOrRandom?
    let baseUrl = "https://www.thecocktaildb.com/api/json/v1/1/search.php?"
    var findCockTailApi = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoading()
        downloadData(withUrlStr: findCockTailApi)
        findTableView.dataSource = self
        findTableView.delegate = self
        findTableView.isHidden = true
        searchBar.delegate = self
        searchBar.isHidden = true
        self.removeLoading()
        
    }
    func downloadData(withUrlStr: String){
        let url = URL(string: withUrlStr)!
        print(url )
        let urlRequest = URLRequest(url: url)
        DispatchQueue.global().async {
            AF.request(urlRequest).response { response in
                switch response.result {
                case .success(let data):
                    print("Yahoo We have Received Data")
                    if let data = data  {
                        let decoder = JSONDecoder()
                        do{
                            self.findIngradientArray  = try decoder.self.decode(DrinkorBFirstLtrOrRandom.self, from: data) as DrinkorBFirstLtrOrRandom
                            DispatchQueue.main.async {
                                print("We have succesfully Decoded the data")
                                self.filteredData = self.findIngradientArray?.drinks
                                self.findTableView.reloadData()
                            }
                        }catch{
                            print("Error In Decoding Data",error.localizedDescription)
                        }
                    }else {
                        print("Data is Nil")
                    }
                    
                case .failure(let error):
                    print("Error Fetching Data",error.localizedDescription)
                }
            }
        }
        
    }
    @IBAction func returnApiOnSelection(sender: UIControl){
        if sender.tag == 11{
            self.searchByIngradientView.isHidden = true
            self.findACocktailView.isHidden = true
            self.findRandomCocktail.isHidden = true
            self.showLoading()
            downloadData(withUrlStr: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=Gin")
            searchBar.isHidden = false
            self.removeLoading()
            self.findTableView.reloadData()
            self.findTableView.isHidden = false
            
        }
        if sender.tag == 12{
            self.searchByIngradientView.isHidden = true
            self.findACocktailView.isHidden = true
            self.findRandomCocktail.isHidden = true
            self.showLoading()
            downloadData(withUrlStr: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita")
            searchBar.isHidden = false
            self.removeLoading()
            self.findTableView.reloadData()
            self.findTableView.isHidden = false
        }
        if sender.tag == 13{
            self.searchByIngradientView.isHidden = true
            self.findACocktailView.isHidden = true
            self.findRandomCocktail.isHidden = true
            self.showLoading()
            downloadData(withUrlStr: "https://www.thecocktaildb.com/api/json/v1/1/random.php")
            searchBar.isHidden = false
            self.removeLoading()
            self.findTableView.reloadData()
            self.findTableView.isHidden = false
        }
    }
}
extension FindDrinkVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindDrinkTblCell", for: indexPath) as! FindDrinkTblCell
        
        guard let cocktail = filteredData?[indexPath.row] else {return cell}
        cell.updateUI(with: cocktail)
        return cell
    }
}
extension FindDrinkVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataToSend = filteredData?[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CockTailInfoVC") as! CockTailInfoVC
        vc.data = dataToSend
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension FindDrinkVC: UISearchBarDelegate{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        findTableView.isHidden = false
        self.findTableView.reloadData()
        searchByIngradientView.isHidden = true
        findACocktailView.isHidden = true
        findRandomCocktail.isHidden = true
    }
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.isHidden = true
        self.findTableView.isHidden = false
        self.searchByIngradientView.isHidden = false
        self.findACocktailView.isHidden = false
        self.findRandomCocktail.isHidden = false
    }
    @objc func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let drinks = findIngradientArray?.drinks else {return}
        let filteredDrinks = drinks.filter { drink in
            if let range = drink.strDrink!.range(of: searchText, options: .caseInsensitive) {
                print("Given Range",range)
                findTableView.reloadData()
                return !range.isEmpty
            }
            return false
        }
        
    }
}
