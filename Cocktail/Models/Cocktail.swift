//
//  CetogoriesDataModel.swift
//  Cocktail
//
//  Created by Bharat Silavat on 12/03/23.
//

import Foundation

struct DrinkorBFirstLtrOrRandom: Codable {
    
    var drinks: [Cocktail]
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.drinks, forKey: .drinks)
    }
    enum CodingKeys: CodingKey {
        case drinks
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.drinks = try container.decode([Cocktail].self, forKey: .drinks)
    }
}

struct Cocktail: Codable {
    var idDrink: String?
    var strTags: String?
    var strDrink: String?
    var strCategory: String?
    var strAlcoholic: String
    var strGlass: String?
    var strInstructions: String?
    var strDrinkThumb: String?
    
    var strIngredient1 : String?
    var strIngredient2 : String?
    var strIngredient3 : String?
    var strIngredient4 : String?
    var strIngredient5 : String?
    var strIngredient6 : String?
    var strIngredient7 : String?
    var strIngredient8 : String?
    var strIngredient9 : String?
    var strIngredient10 : String?
    var strIngredient11 : String?
    var strIngredient12 : String?
    var strIngredient13 : String?
    var strIngredient14 : String?
    var strIngredient15: String?
    
    var strMeasure1 : String?
    var strMeasure2 : String?
    var strMeasure3 : String?
    var strMeasure4 : String?
    var strMeasure5 : String?
    var strMeasure6 : String?
    var strMeasure7 : String?
    var strMeasure8 : String?
    var strMeasure9 : String?
    var strMeasure10 : String?
    var strMeasure11 : String?
    var strMeasure12 : String?
    var strMeasure13 : String?
    var strMeasure14 : String?
    var strMeasure15 : String?
    var strImageSource : String?
    var strImageAttribution : String?
    
    var strCreativeCommonsConfirmed: String?
    var dateModified: String?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.idDrink, forKey: .idDrink)
        try container.encodeIfPresent(self.strTags, forKey: .strTags)
        try container.encodeIfPresent(self.strDrink, forKey: .strDrink)
        try container.encodeIfPresent(self.strCategory, forKey: .strCategory)
        try container.encode(self.strAlcoholic, forKey: .strAlcoholic)
        try container.encodeIfPresent(self.strGlass, forKey: .strGlass)
        try container.encodeIfPresent(self.strInstructions, forKey: .strInstructions)
        try container.encodeIfPresent(self.strDrinkThumb, forKey: .strDrinkThumb)
        try container.encodeIfPresent(self.strIngredient1, forKey: .strIngredient1)
        try container.encodeIfPresent(self.strIngredient2, forKey: .strIngredient2)
        try container.encodeIfPresent(self.strIngredient3, forKey: .strIngredient3)
        try container.encodeIfPresent(self.strIngredient4, forKey: .strIngredient4)
        try container.encodeIfPresent(self.strIngredient5, forKey: .strIngredient5)
        try container.encodeIfPresent(self.strIngredient6, forKey: .strIngredient6)
        try container.encodeIfPresent(self.strIngredient7, forKey: .strIngredient7)
        try container.encodeIfPresent(self.strIngredient8, forKey: .strIngredient8)
        try container.encodeIfPresent(self.strIngredient9, forKey: .strIngredient9)
        try container.encodeIfPresent(self.strIngredient10, forKey: .strIngredient10)
        try container.encodeIfPresent(self.strIngredient11, forKey: .strIngredient11)
        try container.encodeIfPresent(self.strIngredient12, forKey: .strIngredient12)
        try container.encodeIfPresent(self.strIngredient13, forKey: .strIngredient13)
        try container.encodeIfPresent(self.strIngredient14, forKey: .strIngredient14)
        try container.encodeIfPresent(self.strIngredient15, forKey: .strIngredient15)
        try container.encodeIfPresent(self.strMeasure1, forKey: .strMeasure1)
        try container.encodeIfPresent(self.strMeasure2, forKey: .strMeasure2)
        try container.encodeIfPresent(self.strMeasure3, forKey: .strMeasure3)
        try container.encodeIfPresent(self.strMeasure4, forKey: .strMeasure4)
        try container.encodeIfPresent(self.strMeasure5, forKey: .strMeasure5)
        try container.encodeIfPresent(self.strMeasure6, forKey: .strMeasure6)
        try container.encodeIfPresent(self.strMeasure7, forKey: .strMeasure7)
        try container.encodeIfPresent(self.strMeasure8, forKey: .strMeasure8)
        try container.encodeIfPresent(self.strMeasure9, forKey: .strMeasure9)
        try container.encodeIfPresent(self.strMeasure10, forKey: .strMeasure10)
        try container.encodeIfPresent(self.strMeasure11, forKey: .strMeasure11)
        try container.encodeIfPresent(self.strMeasure12, forKey: .strMeasure12)
        try container.encodeIfPresent(self.strMeasure13, forKey: .strMeasure13)
        try container.encodeIfPresent(self.strMeasure14, forKey: .strMeasure14)
        try container.encodeIfPresent(self.strMeasure15, forKey: .strMeasure15)
        try container.encodeIfPresent(self.strImageSource, forKey: .strImageSource)
        try container.encodeIfPresent(self.strImageAttribution, forKey: .strImageAttribution)
        try container.encodeIfPresent(self.strCreativeCommonsConfirmed, forKey: .strCreativeCommonsConfirmed)
        try container.encodeIfPresent(self.dateModified, forKey: .dateModified)
    }
    
    enum CodingKeys: CodingKey {
        case idDrink
        case strTags
        case strDrink
        case strCategory
        case strAlcoholic
        case strGlass
        case strInstructions
        case strDrinkThumb
        case strIngredient1
        case strIngredient2
        case strIngredient3
        case strIngredient4
        case strIngredient5
        case strIngredient6
        case strIngredient7
        case strIngredient8
        case strIngredient9
        case strIngredient10
        case strIngredient11
        case strIngredient12
        case strIngredient13
        case strIngredient14
        case strIngredient15
        case strMeasure1
        case strMeasure2
        case strMeasure3
        case strMeasure4
        case strMeasure5
        case strMeasure6
        case strMeasure7
        case strMeasure8
        case strMeasure9
        case strMeasure10
        case strMeasure11
        case strMeasure12
        case strMeasure13
        case strMeasure14
        case strMeasure15
        case strImageSource
        case strImageAttribution
        case strCreativeCommonsConfirmed
        case dateModified
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.idDrink = try container.decodeIfPresent(String.self, forKey: .idDrink)
        self.strTags = try container.decodeIfPresent(String.self, forKey: .strTags)
        self.strDrink = try container.decodeIfPresent(String.self, forKey: .strDrink)
        self.strCategory = try container.decodeIfPresent(String.self, forKey: .strCategory)
        self.strAlcoholic = try container.decode(String.self, forKey: .strAlcoholic)
        self.strGlass = try container.decodeIfPresent(String.self, forKey: .strGlass)
        self.strInstructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)
        self.strDrinkThumb = try container.decodeIfPresent(String.self, forKey: .strDrinkThumb)
        self.strIngredient1 = try container.decodeIfPresent(String.self, forKey: .strIngredient1)
        self.strIngredient2 = try container.decodeIfPresent(String.self, forKey: .strIngredient2)
        self.strIngredient3 = try container.decodeIfPresent(String.self, forKey: .strIngredient3)
        self.strIngredient4 = try container.decodeIfPresent(String.self, forKey: .strIngredient4)
        self.strIngredient5 = try container.decodeIfPresent(String.self, forKey: .strIngredient5)
        self.strIngredient6 = try container.decodeIfPresent(String.self, forKey: .strIngredient6)
        self.strIngredient7 = try container.decodeIfPresent(String.self, forKey: .strIngredient7)
        self.strIngredient8 = try container.decodeIfPresent(String.self, forKey: .strIngredient8)
        self.strIngredient9 = try container.decodeIfPresent(String.self, forKey: .strIngredient9)
        self.strIngredient10 = try container.decodeIfPresent(String.self, forKey: .strIngredient10)
        self.strIngredient11 = try container.decodeIfPresent(String.self, forKey: .strIngredient11)
        self.strIngredient12 = try container.decodeIfPresent(String.self, forKey: .strIngredient12)
        self.strIngredient13 = try container.decodeIfPresent(String.self, forKey: .strIngredient13)
        self.strIngredient14 = try container.decodeIfPresent(String.self, forKey: .strIngredient14)
        self.strIngredient15 = try container.decodeIfPresent(String.self, forKey: .strIngredient15)
        self.strMeasure1 = try container.decodeIfPresent(String.self, forKey: .strMeasure1)
        self.strMeasure2 = try container.decodeIfPresent(String.self, forKey: .strMeasure2)
        self.strMeasure3 = try container.decodeIfPresent(String.self, forKey: .strMeasure3)
        self.strMeasure4 = try container.decodeIfPresent(String.self, forKey: .strMeasure4)
        self.strMeasure5 = try container.decodeIfPresent(String.self, forKey: .strMeasure5)
        self.strMeasure6 = try container.decodeIfPresent(String.self, forKey: .strMeasure6)
        self.strMeasure7 = try container.decodeIfPresent(String.self, forKey: .strMeasure7)
        self.strMeasure8 = try container.decodeIfPresent(String.self, forKey: .strMeasure8)
        self.strMeasure9 = try container.decodeIfPresent(String.self, forKey: .strMeasure9)
        self.strMeasure10 = try container.decodeIfPresent(String.self, forKey: .strMeasure10)
        self.strMeasure11 = try container.decodeIfPresent(String.self, forKey: .strMeasure11)
        self.strMeasure12 = try container.decodeIfPresent(String.self, forKey: .strMeasure12)
        self.strMeasure13 = try container.decodeIfPresent(String.self, forKey: .strMeasure13)
        self.strMeasure14 = try container.decodeIfPresent(String.self, forKey: .strMeasure14)
        self.strMeasure15 = try container.decodeIfPresent(String.self, forKey: .strMeasure15)
        self.strImageSource = try container.decodeIfPresent(String.self, forKey: .strImageSource)
        self.strImageAttribution = try container.decodeIfPresent(String.self, forKey: .strImageAttribution)
        self.strCreativeCommonsConfirmed = try container.decodeIfPresent(String.self, forKey: .strCreativeCommonsConfirmed)
        self.dateModified = try container.decodeIfPresent(String.self, forKey: .dateModified)
    }
}
