//
//  MainNavController.swift
//  GODex
//
//  Created by Tyler Vergin on 3/14/23.
//

import UIKit

var myDex: Pokedex = Pokedex(temp: 0)

class MainNavVC: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        MyAPIHandler.makeRequests()
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
