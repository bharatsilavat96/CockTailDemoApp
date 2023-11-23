//
//  GlassModel.swift
//  Cocktail
//
//  Created by Bharat Silavat on 13/03/23.
//

import Foundation

struct Glass: Codable{
   
    var drinks: [GlassA]?
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.drinks, forKey: .drinks)
    }
    enum CodingKeys: CodingKey {
        case drinks
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.drinks = try container.decodeIfPresent([GlassA].self, forKey: .drinks)
    }
}
struct GlassA: Codable{
   
    var strGlass: String?
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.strGlass, forKey: .strGlass)
    }
    enum CodingKeys: CodingKey {
        case strGlass
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.strGlass = try container.decodeIfPresent(String.self, forKey: .strGlass)
    }
}
