//
//  UserSettingsVC.swift
//  GODex
//
//  Created by Tyler Vergin on 3/16/23.
//

import UIKit

class UserSettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func resetPokedex(_ sender: Any) {
        for pokemon in myDex.pokemonArr {
            pokemon.userHasOne = false
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
