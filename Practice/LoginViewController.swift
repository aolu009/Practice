//
//  ViewController.swift
//  TwitterReMake
//
//  Created by Lu Ao on 8/11/17.
//  Copyright © 2017 Lu Ao. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginButton()
        // Do any additional setup after loading the view, typically from a nib.
    }
    


    @IBAction func onLogin(_ sender: Any) {
        loginButton.isSelected = false
        UserAccount.currentUser?.login(success: { 
            self.goToProfileView()
        }, fail: {
            print("login fail")
        })
    }
    
    func goToProfileView(){
        let hamburgerStoryboard = UIStoryboard(name: "Hamburger", bundle: nil)
        let menuStoryboard = UIStoryboard(name: "Menu", bundle: nil)
        let hamburgerViewController = hamburgerStoryboard.instantiateViewController(withIdentifier: "HamburgerViewController") as! HamburgerViewController
        let menuViewController = menuStoryboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        menuViewController.hamburgerViewController = hamburgerViewController
        hamburgerViewController.menuViewController = menuViewController
        
        self.present(hamburgerViewController, animated: true, completion: nil)
    }
    
    private func setupLoginButton(){
        loginButton.setTitle("Login", for: .normal)
    }
    
    
}

