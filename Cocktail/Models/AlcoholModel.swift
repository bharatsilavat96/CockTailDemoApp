//
//  AlcoholModel.swift
//  Cocktail
//
//  Created by Bharat Silavat on 13/03/23.
//

import Foundation

struct Alcahol: Codable{
    var drinks: [Alcoholic]?
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.drinks, forKey: .drinks)
    }
    enum CodingKeys: CodingKey {
        case drinks
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.drinks = try container.decodeIfPresent([Alcoholic].self, forKey: .drinks)
    }
}
struct Alcoholic: Codable {
    
    var strAlcoholic: String?
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.strAlcoholic, forKey: .strAlcoholic)
    }
    enum CodingKeys: CodingKey {
        case strAlcoholic
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.strAlcoholic = try container.decodeIfPresent(String.self, forKey: .strAlcoholic)
    }
    
}
