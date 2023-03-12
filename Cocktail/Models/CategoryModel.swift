//
//  CategoryModel.swift
//  Cocktail
//
//  Created by Bharat Silavat on 12/03/23.
//

import Foundation

struct LatestDrinkOrIngredient: Codable{
    let drinks: [LDrink]?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.drinks, forKey: .drinks)
    }
    enum CodingKeys: CodingKey {
        case drinks
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.drinks = try container.decodeIfPresent([LDrink].self, forKey: .drinks)
    }
}
struct LDrink: Codable{
    
    let strDrink: String?
    let strDrinkThumb: String?
    let idDrink: String?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.strDrink, forKey: .strDrink)
        try container.encodeIfPresent(self.strDrinkThumb, forKey: .strDrinkThumb)
        try container.encodeIfPresent(self.idDrink, forKey: .idDrink)
    }
    enum CodingKeys: CodingKey {
        case strDrink
        case strDrinkThumb
        case idDrink
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.strDrink = try container.decodeIfPresent(String.self, forKey: .strDrink)
        self.strDrinkThumb = try container.decodeIfPresent(String.self, forKey: .strDrinkThumb)
        self.idDrink = try container.decodeIfPresent(String.self, forKey: .idDrink)
    }
   
}
