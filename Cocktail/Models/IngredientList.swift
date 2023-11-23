//
//  IngredientList.swift
//  Cocktail
//
//  Created by Bharat Silavat on 13/03/23.
//

import Foundation


struct DrinkIngredients: Codable {
    var drinks: [Ingredient]?
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.drinks, forKey: .drinks)
    }
    enum CodingKeys: CodingKey {
        case drinks
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.drinks = try container.decodeIfPresent([Ingredient].self, forKey: .drinks)
    }
}

struct Ingredient: Codable {
    let strIngredient1: String?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.strIngredient1, forKey: .strIngredient1)
    }
    enum CodingKeys: CodingKey {
        case strIngredient1
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.strIngredient1 = try container.decodeIfPresent(String.self, forKey: .strIngredient1)
    }
    
}
