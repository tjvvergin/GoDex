//
//  Pokemon.swift
//  GODex
//
//  Created by Tyler Vergin on 3/4/23.
//

import Foundation
import UIKit

class Pokemon {
    //inherent pokemon stats
    let id: Int
    let name: String
    var generation: Int = 0
    var mainImage: UIImage?
    var mainShinyImage: UIImage?
    var pokemonImages: [UIImage] = []
    var isReleased: Bool = false
    //important details
    var maxCP: Int = 0
    var shinyDetails: ShinyPokemon?
    var canBeShiny: Bool {
        if shinyDetails != nil {
            return shinyDetails!.foundEgg || shinyDetails!.foundEvolution || shinyDetails!.foundPhotobomb || shinyDetails!.foundRAID || shinyDetails!.foundWild
        } else {return false}
    }
    var types: [TypeElement] = []
    var evolvesInto: [Evolution]?
    var megaEvolutions: MegaPokemons = []
    var isBaby: Bool = false
    //user details
    var userHasOne: Bool = false
    var userHasShiny: Bool = false
    var userHasHundo: Bool = false
    var userHasShundo: Bool = false
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
        
    }
    
    func getGeneration () -> Int { return self.generation }
    func setGeneration (_ gen: Int) { self.generation = gen }
    
    func getReleased () -> Bool { return self.isReleased }
    func setReleased (_ isReleased: Bool) { self.isReleased = isReleased }
    
    
    func getEvolvesInto () -> [Evolution]? { return self.evolvesInto }
    func setEvolvesInto (_ evolvesInto: [Evolution]) { self.evolvesInto = evolvesInto }
    
    func getMegaEvolutions () -> MegaPokemons { return self.megaEvolutions }
    func addMegaEvolution (_ megaEvolution: MegaPokemon) { self.megaEvolutions.append(megaEvolution) }
    
    func getIsBaby () -> Bool { return self.isBaby }
    func setIsBaby (_ isBaby: Bool) { self.isBaby = isBaby }
    
    func getShiny () -> ShinyPokemon? { return self.shinyDetails }
    func setShiny (_ canBeShiny: ShinyPokemon) { self.shinyDetails = canBeShiny }
    
    func getTyping () -> [TypeElement] { return self.types }
    func setTyping (_ types: [TypeElement]) { self.types = types }
    
    func getMaxCP () -> Int { return self.maxCP }
    func setMaxCP (_ maxCP: Int) { self.maxCP = maxCP }
    
    func getPokemonImages() -> [UIImage] {
        var formattedName = name
        switch formattedName {
        case "Nidoran♀": formattedName = "nidoran-f"
        case "Nidoran♂": formattedName = "nidoran-m"
        case "Farfetch’d": formattedName = "farfetchd"
        case "Mr. Mime": formattedName = "mr-mime"
        case "Mime Jr.": formattedName = "mime-jr"
        case "Tapu Koko": formattedName = "tapu-koko"
        case "Tapu Lele": formattedName = "tapu-lele"
        case "Tapu Bulu": formattedName = "tapu-bulu"
        case "Tapu Fini": formattedName = "tapu-fini"
        case "Sirfetch’d": formattedName = "sirfetchd"
        case "Mr. Rime": formattedName = "mr-rime"
        default: formattedName = formattedName.lowercased()
        }
        
        if let imageNames = MyAPIHandler.getPokemonImageNames() {
            //initialize images array for output
            var images: [UIImage] = []
            for imageName in imageNames {
                //cast to nsstring to check if prefix of file meets expectations
                let fileName = (imageName as NSString).lastPathComponent
                if fileName.hasPrefix(formattedName) || fileName.hasPrefix("shiny-\(formattedName)") {
                    if let image = UIImage(named: imageName) {
                        if fileName == ("\(formattedName).png") {
                            //check if it is the main image
                            mainImage = image
                        } else if fileName == ("shiny-\(formattedName).png") {
                            //check if it is the main image of the shiny variant
                            mainShinyImage = image
                        }
                        images.append(image)
                    }
                }
            }
        if images.isEmpty {
            print("No images found for \(name)")
        } else if (mainImage == nil) {
            backupMainImageFinder()
            if (mainImage == nil) {
                print("No main images found for \(name)")
            }
        }
        self.pokemonImages = images
        }
    return self.pokemonImages
        
    }
    
    func backupMainImageFinder () {
    var imageName: String = ""
        switch name {
        case "Unown": imageName = "unown-a"
        case "Spinda": imageName = "spinda-01"
        case "Deoxys": imageName = "deoxys-normal"
        case "Burmy": imageName = "burmy-plant"
        case "Wormadam": imageName = "wormadam-plant"
        case "Cherrim": imageName = "cherrim-sunshine"
        case "Shellos": imageName = "shellos-east"
        case "Gastrodon": imageName = "gastrodon-east"
        case "Giratina": imageName = "giratina-altered"
        case "Shaymin": imageName = "shaymin-sky"
        case "Basculin": imageName = "basculin-blue-striped"
        case "Darmanitan": imageName = "darmanitan-standard"
        case "Deerling": imageName = "deerling-summer"
        case "Sawsbuck": imageName = "sawsbuck-summer"
        case "Tornadus": imageName = "tornadus-incarnate"
        case "Thundurus": imageName = "thundurus-incarnate"
        case "Landorus": imageName = "landorus-incarnate"
        case "Keldeo": imageName = "keldeo-resolute"
        case "Meloetta": imageName = "meloetta-aria"
        case "Vivillon": imageName = "vivillon-elegant"
        case "Flabebe": imageName = "flabebe-yellow"
        case "Floette": imageName = "floette-yellow"
        case "Florges": imageName = "florges-yellow"
        case "Furfrou": imageName = "furfrou-natural"
        case "Meowstic": imageName = "meowstic-female"
        case "Pumpkaboo": imageName = "pumpkaboo-super"
        case "Gourgeist": imageName = "gourgeist-super"
        case "Hoopa": imageName = "hoopa-confined"
        case "Oricorio": imageName = "oricorio-pom-pom"
        case "Lycanroc": imageName = "lycanroc-midnight"
        case "Zacian": imageName = "zacian-hero"
        case "Zamazenta": imageName = "zamazenta-hero"
        default: break
        }
        mainImage = UIImage(named: imageName)
        mainShinyImage = UIImage(named: "shiny-\(imageName)")
    }
    
    
}
