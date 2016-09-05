//
//  LoggedInViewController.swift
//  Connekt
//
//  Created by Jae Hyun Kim on 8/31/16.
//
//

import UIKit
import AWSMobileHubHelper

class LoggedInViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    let currentUser = CurrentUser.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logoutButton.addTarget(self, action: #selector(LoggedInViewController.handleLogout), forControlEvents: .TouchUpInside)
    }
    
    func setLogInAndSignUpViewController() {
        let storyboard = UIStoryboard(name: "LogInAndSignUp", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("LogInAndSignUpViewController")
        self.presentViewController(vc, animated: true, completion: nil)
    }

    func handleLogout() {
        
        if (currentUser.loggedIn()) {
            currentUser.logOut({ (result, error) in
                self.setLogInAndSignUpViewController()
            })
            print("Logout Successful: )");
  

        } else {
            assert(false)
        }
        
        
        
    }

}
