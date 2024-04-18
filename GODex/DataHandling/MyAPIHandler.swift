//
//  MyAPIHandler.swift
//  GODex
//
//  Created by Tyler Vergin on 3/2/23.
//


import Foundation
class MyAPIHandler {
    //stores the filename requested into the documents folder to be read later
    static func storeAPIRequest(fileName: String) {
        let url = URL(string: "https://pogoapi.net/api/v1/" + fileName)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            //debugPrint(data)
            //debugPrint(response)
            let fileManager = FileManager.default
            let documentDirectory = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let fileURL = documentDirectory.appendingPathComponent(fileName)
            debugPrint("Writing to: \(fileURL)")
            do {
                try data.write(to: fileURL)
                debugPrint("Successful writing to: \(fileName)")
            } catch {
                debugPrint("Data writing failed with error: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
            
    
    /*
    //reads the json file from the documents folder into the specified return type
    static func readJSONFileOld<T: Codable>(fileName: String, type: T.Type, returnType: returnType ) -> (any Collection)? {
        let fileManager = FileManager.default
        let documentDirectory = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        debugPrint("Reading from: ")
        debugPrint(fileURL)

        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        switch returnType {
        case .Arr:
            do {
                let decoder = JSONDecoder()
                let decodedDict = try decoder.decode([T].self, from: data)
                
                return decodedDict
            } catch {
                print(error)
            }
        case .DictIntArr:
            do {
                let decoder = JSONDecoder()
                let decodedDict = try decoder.decode([Int:[T]].self, from: data)
                
                return decodedDict
            } catch {
                print(error)
            }
        case .DictIntT:
            do {
                let decoder = JSONDecoder()
                let decodedDict = try decoder.decode([Int:T].self, from: data)
                
                return decodedDict
            } catch {
                print(error)
            }
        case .DictStringArr:
            do {
                let decoder = JSONDecoder()
                let decodedDict = try decoder.decode([String:[T]].self, from: data)
                
                return decodedDict
            } catch {
                print(error)
            }
        default:
            print("This return type is not implemented")
        }
        

        return nil
    }
    */
    static func readJSONFile<T: Codable>(fileName: String, returnType: T.Type) -> T? {
        let fileManager = FileManager.default
        let documentDirectory = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        debugPrint("Reading from: ")
        debugPrint(fileURL)

        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }
    static func getPokemonImageNames() -> [String]? {
        do {
            if let fileURL = Bundle.main.url(forResource: "file_names", withExtension: "json") {
                
                
                let data = try Data(contentsOf: fileURL)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let array = json as? [String] {
                    return array
                } else {
                    print("JSON is not an array of strings")
                    return nil
                }
            }
        } catch {
            print("Error reading JSON file: \(error.localizedDescription)")
            return nil
        }
        return nil
    }
    
    static func makeRequests() {
        MyAPIHandler.storeAPIRequest(fileName: "pokemon_names.json")
        MyAPIHandler.storeAPIRequest(fileName: "released_pokemon.json")
        MyAPIHandler.storeAPIRequest(fileName: "pokemon_generations.json")
        MyAPIHandler.storeAPIRequest(fileName: "pokemon_evolutions.json")
        MyAPIHandler.storeAPIRequest(fileName: "mega_pokemon.json")
        MyAPIHandler.storeAPIRequest(fileName: "baby_pokemon.json")
        MyAPIHandler.storeAPIRequest(fileName: "shiny_pokemon.json")
        MyAPIHandler.storeAPIRequest(fileName: "pokemon_types.json")
        MyAPIHandler.storeAPIRequest(fileName: "pokemon_max_cp.json")
    }
    
    /*
    func checkForUpdatedData() {
        // MARK: TODO
    }
     */
}


