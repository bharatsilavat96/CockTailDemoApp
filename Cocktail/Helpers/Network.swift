//
//  Network.swift
//  Cocktail
//
//  Created by Bharat Silavat on 11/03/23.
//

import Foundation


/*
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
 
 
 func downloadData(withUrlStr: String){
     let url = URL(string: withUrlStr)!
     let urlRequest = URLRequest(url: url)
     DispatchQueue.global().async {
         AF.request(urlRequest).response { response in
             switch response.result {
             case .success(let data):
                 print("Yahoo We have Received Data")
                 if let data = data {
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
 
 @objc func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        guard let drinks = findIngradientArray?.drinks else {return}
//        let filteredDrinks = drinks.filter { drink in
//            if let range = drink.strDrink!.range(of: searchText, options: .caseInsensitive) {
//                print("Given Range",range)
//                findTableView.reloadData()
//                return !range.isEmpty
//            }
//            return false
//        }
     
 }
*/
