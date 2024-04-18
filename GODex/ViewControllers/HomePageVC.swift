//
//  HomeVC.swift
//  GODex
//
//  Created by Tyler Vergin on 3/14/23.
//

import UIKit

class HomePageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if myDex.getPokedexArr().isEmpty {
            myDex = Pokedex()
        }
    }
    

}
