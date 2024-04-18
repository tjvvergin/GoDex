//
//  Pokedex.swift
//  GODex
//
//  Created by Tyler Vergin on 3/5/23.
//

import Foundation


class Pokedex {
    var pokemonArr: [Pokemon]
    var relevantPokedexArr: [Pokemon] = []
    init(temp: Int) {
        pokemonArr = []
    }
    
    init() {
        //store json into files
        //MyAPIHandler.storeAPIRequest(fileName: "pokemon_names.json")
        //read from files into dictionary
        let PokemonNamesArr = MyAPIHandler.readJSONFile(fileName: "pokemon_names.json", returnType: PokemonNames.self)
        if let PokemonNamesArr = PokemonNamesArr {
            //init array with empty pokemon
            pokemonArr = Array(repeating: Pokemon(id: 0, name: ""), count: PokemonNamesArr.count + 1)
            //fill array with actual pokemon values
            for (x,y) in PokemonNamesArr {
                pokemonArr[x] = (Pokemon(id: x, name: y.name))
            }
            //fill pokemon with all associated images
            for i in 1..<pokemonArr.count {
                pokemonArr[i].getPokemonImages()
            }
            
            //Run the rest of the initializers
            initReleased()
            initGenerations()
            initEvolutions()
            initMegaEvolutions()
            initIsBaby()
            initShiny()
            initPokemonTyping()
            initMaxCP()
            print ("Pokemon sorted")
        } else {
            pokemonArr = []
            print("Error occurred when Initializing pokemonArr")
        }
    }
    //function that returns all useful pokedex entries to be used in collectionView
    func getRelevantPokedexArr() -> [Pokemon] {
        var output: [Pokemon] = []
        if relevantPokedexArr.isEmpty {
            for i in 1..<pokemonArr.count {
                if pokemonArr[i].mainImage != nil && pokemonArr[i].id != 0 {
                    output.append(pokemonArr[i])
                }
            }
            relevantPokedexArr = output
        }
        return relevantPokedexArr
    }
    
    func getPokedexArr() -> [Pokemon] {
        return pokemonArr
    }
    func searchPokedexArr(query: String) -> [Pokemon] {
        var output: [Pokemon] = []
        if query != "" {
            //loop through PokemonArr and find pokemon containing text
            for pokemon in relevantPokedexArr {
                if pokemon.name.lowercased().contains(query.lowercased()) {
                    output.append(pokemon)
                }
            }
            return output
        } else { return relevantPokedexArr }
    }
    
    func initReleased() {
        let tempCollection = MyAPIHandler.readJSONFile(fileName: "released_pokemon.json", returnType: ReleasedPokemons.self)
        if let tempCollection = tempCollection {
            for (x,y) in tempCollection {
                if x < pokemonArr.count {
                pokemonArr[x].setReleased(true)
                } else {
                    print("Error Pokemon id: \(x), name: \(y.name)")
                }
            }
        } else {
            print ("Error instantiating collection for initReleased")
        }
    }
    
    func initGenerations() {
        let tempCollection = MyAPIHandler.readJSONFile(fileName: "pokemon_generations.json", returnType: PokemonGenerations.self)
        if let tempCollection = tempCollection {
            for pokemon in tempCollection {
                pokemonArr[pokemon.id].setGeneration(pokemon.generationNumber)
            }
        } else {
            print ("Error instantiating collection for initGenerations")
        }
    }
    
    func initEvolutions() {
        let tempCollection = MyAPIHandler.readJSONFile(fileName: "pokemon_evolutions.json", returnType: PokemonEvolutions.self)
        if let tempCollection = tempCollection {
            for pokemon in tempCollection {
                pokemonArr[pokemon.pokemonID].setEvolvesInto(pokemon.evolutions)
            }
        } else {
            print ("Error instantiating collection for initEvolutions ")
        }
    }
    func initMegaEvolutions() {
        let tempCollection = MyAPIHandler.readJSONFile(fileName: "mega_pokemon.json", returnType: MegaPokemons.self)
        if let tempCollection = tempCollection {
            for megaPokemon in tempCollection {
                pokemonArr[megaPokemon.pokemonID].addMegaEvolution(megaPokemon)
            }
        } else {
            print ("Error instantiating collection for initMegaEvolutions ")
        }
    }
    func initIsBaby() {
        let tempCollection = MyAPIHandler.readJSONFile(fileName: "baby_pokemon.json", returnType: BabyPokemon.self)
        if let tempCollection = tempCollection {
            for babyPokemon in tempCollection {
                pokemonArr[babyPokemon.id].setIsBaby(true)
            }
        } else {
            print ("Error instantiating collection for initIsBaby ")
        }
    }
    func initShiny() {
        let tempCollection = MyAPIHandler.readJSONFile(fileName: "shiny_pokemon.json", returnType: ShinyPokemons.self)
        if let tempCollection = tempCollection {
            for (key, value) in tempCollection {
                pokemonArr[key].setShiny(value)
            }
        } else {
            print ("Error instantiating collection for initShiny ")
        }
    }
    func initPokemonTyping() {
        let tempCollection = MyAPIHandler.readJSONFile(fileName: "pokemon_types.json", returnType: PokemonTyping.self)
        if let tempCollection = tempCollection {
            for pokemon in tempCollection {
                if pokemon.pokemonID < pokemonArr.count {
                    pokemonArr[pokemon.pokemonID].setTyping(pokemon.type)
                } else {
                    print("initPokemonTyping: Error inserting Pokemon id: \(pokemon.pokemonID), name: \(pokemon.pokemonName)")
                }
            }
        } else {
            print ("Error instantiating collection for initPokemonTyping ")
        }
    }
    func initMaxCP() {
        let tempCollection = MyAPIHandler.readJSONFile(fileName: "pokemon_max_cp.json", returnType: MaxCP.self)
        if let tempCollection = tempCollection {
            for pokemon in tempCollection {
                if pokemon.pokemonID < pokemonArr.count {
                    pokemonArr[pokemon.pokemonID].setMaxCP(pokemon.maxCp)
                } else {
                    print("initMaxCP: Error inserting Pokemon id: \(pokemon.pokemonID), name: \(pokemon.pokemonName)")
                }
            }
        } else {
            print ("Error instantiating collection for initMaxCP ")
        }
    }

    
}
