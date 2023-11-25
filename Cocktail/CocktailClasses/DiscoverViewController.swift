//
//  DiscoverViewController.swift
//  Cocktail
//
//  Created by Bharat Silavat on 09/03/23.
//

import UIKit
import Alamofire

class DiscoverViewController: UIViewController, DiscoverCategoryCollectionViewCellDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    let apiList = "https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list"
    var categoryListArray: [Drink] = []
    var cockTailDict: [String:[LatestDrinkOrIngredient]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoading()
        tableView.delegate = self
        tableView.dataSource = self
        downloadList(with: apiList)
        self.removeLoading()
    }
    
    func downloadList(with urlStr: String){
        let url = URL(string: urlStr)
        AF.request(url!).responseDecodable(of: ListDrink.self) { response in
            switch response.result {
            case .success(let decodedData):
                DispatchQueue.main.async {
                    self.categoryListArray = decodedData.drinks!
                    self.categoryData(with: self.categoryListArray)
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    func downloadCategoryData(with category: String){
        let encodedCategory = category.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let collectionViewCatApi = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=\(encodedCategory)"
        if let urlStr = URL(string: collectionViewCatApi) {
            AF.request(urlStr).responseDecodable(of: LatestDrinkOrIngredient.self) { response in
                switch response.result {
                case .success(let decodedData):
                    DispatchQueue.main.async {
                        if var cocktails = self.cockTailDict[category] {
                            cocktails.append(decodedData)
                            self.cockTailDict[category] = cocktails
                        } else {
                            self.cockTailDict[category] = [decodedData]
                        }
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("Error: Invalid URL")
        }
    }
    func categoryData(with categoryArray: [Drink]){
        for cat in categoryArray{
            downloadCategoryData(with: cat.strCategory ?? "")
        }
    }
    func didSelect(item: LDrink) {
        let apiUrl = item.strDrink ?? ""
        let encodeUrl = apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(encodeUrl)"
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CockTailInfoVC") as! CockTailInfoVC
        vc.urlTypeString = url
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension DiscoverViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoryListArray.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section : Int) -> UIView? {
        let size = UIScreen.main.bounds.size
        let view = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: 40))
        view.backgroundColor = .random()
        let categoryNameLbl: UILabel = UILabel()
        categoryNameLbl.text = categoryListArray[section].strCategory
        categoryNameLbl.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        categoryNameLbl.textColor = .white
        view.addSubview(categoryNameLbl)
        categoryNameLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryNameLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            categoryNameLbl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            categoryNameLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            categoryNameLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 5)
            
        ])
        let sectionBtn: UIButton = UIButton(type: .custom)
        sectionBtn.setTitle("list view", for: .normal)
        sectionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        sectionBtn.tag = section
        sectionBtn.addTarget(self, action: #selector(categoryBtnTapped(sender:)), for: .touchUpInside)
        view.addSubview(sectionBtn)
        sectionBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sectionBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            sectionBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            sectionBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            sectionBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 5)
        ])
        return view
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = categoryListArray[section].strCategory ?? ""
        return cockTailDict[category]?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiscoverCategoryTableViewCell", for: indexPath) as! DiscoverCategoryTableViewCell
        let category = categoryListArray[indexPath.section].strCategory ?? ""
        let cocktail = cockTailDict[category]?[indexPath.row]
        cell.delegate = self
        cell.collectionData = cocktail
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.5*Double(indexPath.row)) {
            cell.alpha = 1
        }
    }
    @objc func categoryBtnTapped(sender: UIButton){
        let category = categoryListArray[sender.tag].strCategory ?? ""
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllDrinksVC") as! AllDrinksVC
        vc.cockTails = cockTailDict[category] ?? []
        vc.navigationController?.title = categoryListArray[0].strCategory
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue"{
            _ = segue.destination as! CockTailInfoVC
        }
    }
    
}



