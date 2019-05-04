//
//  MenuViewController.swift
//  gotgame
//
//  Created by Marlon Escobar on 2019-05-01.
//  Copyright © 2019 Marlon Escobar A. All rights reserved.
//

import Foundation
import UIKit
import FirebaseUI

class MenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func logOut(_ sender: UIButton) {
//        exit(0)
        do {
            try Auth.auth().signOut()
        }
        catch {
            print(error)
            print("error: there was a problem logging out")
            //exit(0)
        }
    }
    

}
