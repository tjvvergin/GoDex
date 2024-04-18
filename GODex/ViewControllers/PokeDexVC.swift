//
//  PokeDexViewController.swift
//  GODex
//
//  Created by Tyler Vergin on 3/14/23.
//

import UIKit

private let pokemonCell = "pokemonCell"

private var pokedexData: [Pokemon] {
    return myDex.getRelevantPokedexArr()
}
private var displayedPokedexData: [Pokemon] = pokedexData

class PokeDexVC: UICollectionViewController, UISearchBarDelegate {
    private let sectionInsets = UIEdgeInsets(
      top: 50.0,
      left: 10.0,
      bottom: 50.0,
      right: 10.0)
    private let itemsPerRow: CGFloat = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
        self.collectionView.allowsMultipleSelection = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return displayedPokedexData.count
    }
//MARK: Initialize Cells
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pokemon = displayedPokedexData[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pokemonCell, for: indexPath) as! PokemonCell
        if pokemon.userHasOne {
            cell.backgroundColor = .systemIndigo
        } else {
            cell.backgroundColor = .darkGray
        }
        if !pokemon.isReleased {
            cell.backgroundColor = .lightGray
        }
    
        // Configure the cell
        cell.pokemon = pokemon
        cell.pokemonName.text = pokemon.name
        cell.pokemonID.text = "#\(pokemon.id)"
        cell.pokemonImage.image = pokemon.mainImage
        
        return cell
    }
    
    //MARK: Initialize Searchbar
    override func collectionView(
      _ collectionView: UICollectionView,
      viewForSupplementaryElementOfKind kind: String,
      at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let searchView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "PokedexHeader", for: indexPath)
        return searchView
    }
    /*
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        displayedPokedexData = myDex.searchPokedexArr(query: searchBar.text ?? "")
        //self.collectionView.reloa
        self.collectionView.reloadData()
    }
    */
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        displayedPokedexData = myDex.searchPokedexArr(query: searchBar.text?.lowercased() ?? "")
        resignFirstResponder()
        self.collectionView.reloadData()
        
    }
    
    
    

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /*
        if displayedPokedexData[indexPath.item].userHasOne == true {
            displayedPokedexData[indexPath.item].userHasOne = false
        } else {
            displayedPokedexData[indexPath.item].userHasOne = true
        }
        self.collectionView.reloadData()
         */
    }
     
    
    override func collectionView(_ collectionView: UICollectionView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
        // Returning `true` automatically sets `collectionView.isEditing`
        // to `true`. The app sets it to `false` after the user taps the Done button.
        return true
    }

    override func collectionView(_ collectionView: UICollectionView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath) {
        // Replace the Select button with Done, and put the
        // collection view into editing mode.
        setEditing(true, animated: true)
        for index in indexPath {
            if displayedPokedexData[index].userHasOne == true {
                displayedPokedexData[index].userHasOne = false
            } else {
                displayedPokedexData[index].userHasOne = true
            }
        }
        self.collectionView.isScrollEnabled = false
        self.collectionView.reloadData()
        
    }
    
    override func collectionViewDidEndMultipleSelectionInteraction(_ collectionView: UICollectionView) {
        self.collectionView.isScrollEnabled = true
        print("\(#function)")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let cellSender = sender as? PokemonCell {
            if let detailViewController = segue.destination as? PokemonDetailsVC {
                
                let pID = Int((cellSender.pokemonID.text?.replacingOccurrences(of: "#", with: ""))!)
                detailViewController.pokemon = myDex.pokemonArr[pID!]
                
            }
        }
    }
    
}
// MARK: - Collection View Flow Layout Delegate
extension PokeDexVC: UICollectionViewDelegateFlowLayout {
  // 1
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    // 2
    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / itemsPerRow
    
    return CGSize(width: widthPerItem, height: widthPerItem)
  }
  
  // 3
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    return sectionInsets
  }
  
  // 4
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    return sectionInsets.left
  }
}
