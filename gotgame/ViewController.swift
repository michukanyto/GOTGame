//
//  ViewController.swift
//  gotgame
//
//  Created by Marlon Escobar on 2019-05-01.
//  Copyright © 2019 Marlon Escobar A. All rights reserved.
//
import UIKit
import FirebaseUI

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        //Get the default Auth UI object
        let authUI = FUIAuth.defaultAuthUI()
        guard authUI != nil else{
            //log error
            return
        }
        //Set ourselves as the delegate
        authUI?.delegate = self as FUIAuthDelegate
        authUI?.providers = [FUIEmailAuth()]
        //Get a reference to the Auth UI view Controller
        let authViewController = authUI!.authViewController()
        //show it
        present(authViewController, animated: true, completion: nil)
    }
    
}

extension ViewController :FUIAuthDelegate{
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        //check if there was an error
        
        guard error == nil else{
            //log the error
            return
        }
        
        //authDataResult?.user.uid
        performSegue(withIdentifier: "mainMenu", sender: self)
        
    }
}
