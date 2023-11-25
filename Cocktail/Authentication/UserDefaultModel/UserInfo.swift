//
//  UserInfo.swift
//  Cocktail
//
//  Created by Bharat Silavat on 11/03/23.
//

import Foundation

struct UserModel: Codable {
    var firstName: String?
    var lastName: String?
    var country: String?
    var email: String?
    var password: String?
    var age: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case country
        case email
        case password
        case age
    }
    
    init(firstName: String?, lastName: String?, country: String?, email: String?, password: String?, age: String?) {
        self.firstName = firstName
        self.lastName = lastName
        self.country = country
        self.email = email
        self.password = password
        self.age = age
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.country = try container.decode(String.self, forKey: .country)
        self.email = try container.decode(String.self, forKey: .email)
        self.password = try container.decode(String.self, forKey: .password)
        self.age = try container.decode(String.self, forKey: .age)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.firstName, forKey: .firstName)
        try container.encodeIfPresent(self.lastName, forKey: .lastName)
        try container.encodeIfPresent(self.country, forKey: .country)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.password, forKey: .password)
        try container.encodeIfPresent(self.age, forKey: .age)
    }
}
