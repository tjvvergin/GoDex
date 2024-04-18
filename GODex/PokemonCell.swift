//
//  CollectedPokemonCell.swift
//  GODex
//
//  Created by Tyler Vergin on 3/14/23.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    var pokemon: Pokemon = Pokemon(id: 0, name: "")
    @IBOutlet weak var pokemonID: UILabel!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
}
