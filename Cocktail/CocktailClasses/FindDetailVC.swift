//
//  FindDetailVC.swift
//  Cocktail
//
//  Created by Bharat Silavat on 13/03/23.
//

import UIKit
import Alamofire

class FindDetailVC: UIViewController {
    
    @IBOutlet weak var findDetailTableView: UITableView!
    
    var allTypeDetail: LatestDrinkOrIngredient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findDetailTableView.delegate = self
        findDetailTableView.dataSource = self
    }
    
    func downLoadData(withUrl: String){
        let url = URL(string: withUrl)!
        let request = URLRequest(url: url)
        AF.request(request).responseData { response in
            switch response.result {
            case .success(let data):
                print(data)
                let decoder = JSONDecoder()
                do{
                    let decodedData = try decoder.self.decode(LatestDrinkOrIngredient.self, from: data)
                    DispatchQueue.main.async {
                        self.allTypeDetail = decodedData
                        self.findDetailTableView.dataSource = self
                        self.findDetailTableView.reloadData()
                    }
                }catch {
                    print("Error in Decoding :",error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
extension FindDetailVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTypeDetail?.drinks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindDrinkTblCell", for: indexPath) as! FindDrinkTblCell
        cell.selectionStyle = .none
        let data = allTypeDetail?.drinks?[indexPath.row]
        cell.updateUI(with: data)
        return cell
    }
}
extension FindDetailVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataToSend = allTypeDetail?.drinks?[indexPath.row].strDrink ?? ""
        let api = dataToSend.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlStr = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(api ?? "")"
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CockTailInfoVC") as! CockTailInfoVC
        vc.urlTypeString = urlStr
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
