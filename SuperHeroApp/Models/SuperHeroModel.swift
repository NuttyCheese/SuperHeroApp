//
//  SuperHeroModel.swift
//  SuperHeroApp
//
//  Created by Борис Павлов on 19.06.2022.
//

import Foundation

enum Link: String {
    case heroUrl = "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/all.json"
}

struct SuperHeroModel: Codable {
    let name: String
    let powerstats: Powerstats
    let appearance: Appearance
    let biography: Biography
    let work: Work
    let images: Images
}

struct Powerstats: Codable {
    let intelligence: Int
    let strength: Int
    let speed: Int
    let durability: Int
    let power: Int
    let combat: Int
}

struct Appearance: Codable {
    let gender: String
    let height: [String]
    let weight: [String]
}

struct Biography: Codable {
    let fullName: String
    let alterEgos: String
    let aliases: [String]
    let firstAppearance: String
    let alignment: String
}

struct Work: Codable {
    let occupation: String
}

struct Images: Codable {
    let sm: String
    let lg: String
}
