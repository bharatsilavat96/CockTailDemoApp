//
//  File.swift
//  Cocktail
//
//  Created by Bharat Silavat on 11/03/23.
//

import Foundation

struct ListDrink: Codable {
    let drinks: [Drink]?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.drinks, forKey: .drinks)
    }
    enum CodingKeys: CodingKey {
        case drinks
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.drinks = try container.decodeIfPresent([Drink].self, forKey: .drinks)
    }
}
struct Drink: Codable {
    let strCategory: String?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.strCategory, forKey: .strCategory)
    }
    enum CodingKeys: CodingKey {
        case strCategory
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.strCategory = try container.decodeIfPresent(String.self, forKey: .strCategory)
    }
}
