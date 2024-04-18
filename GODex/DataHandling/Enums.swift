//
//  Enums.swift
//  GODex
//
//  Created by Tyler Vergin on 3/6/23.
//

import Foundation

enum returnType {
    case DictIntArr
    case DictIntT
    case DictStringT
    case DictStringArr
    case DictStringDict
    case Arr
}



enum Rarity: String, Codable {
    case legendary = "Legendary"
    case mythic = "Mythic"
    case standard = "Standard"
    case ultraBeast = "Ultra beast"
}


