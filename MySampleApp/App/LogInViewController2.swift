//
//  LogInViewController.swift
//  Connekt
//
//  Created by Jae Hyun Kim on 8/30/16.
//
//

import UIKit
import AWSMobileHubHelper
import FBSDKLoginKit

class LogInViewController: UIViewController {

   
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    var didSignInObserver: AnyObject!
    var signOutObserver: AnyObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        didSignInObserver =  NSNotificationCenter.defaultCenter().addObserverForName(AWSIdentityManagerDidSignInNotification, object: AWSIdentityManager.defaultIdentityManager(), queue: NSOperationQueue.mainQueue(), usingBlock: {(note: NSNotification) -> Void in
            
            print(AWSIdentityManager.defaultIdentityManager().loggedIn)
            print("YO333")
            self.performSegueWithIdentifier("searchPage", sender: nil)
            
        })
        AWSFacebookSignInProvider.sharedInstance().setPermissions(["public_profile"]);
        facebookButton.addTarget(self, action: #selector(LogInViewController.handleFacebookLogin), forControlEvents: .TouchUpInside)
        
        logoutButton.addTarget(self, action: #selector(LogInViewController.handleLogout), forControlEvents: .TouchUpInside)

    }
    
    func handleLogout() {
        if (AWSIdentityManager.defaultIdentityManager().loggedIn) {
            ColorThemeSettings.sharedInstance.wipe()
            AWSIdentityManager.defaultIdentityManager().logoutWithCompletionHandler({(result: AnyObject?, error: NSError?) -> Void in
                self.navigationController!.popToRootViewControllerAnimated(false)

            })
            print("Logout Successful: )");
        } else {
            assert(false)
        }
    }
    

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(didSignInObserver)
    }
    
    func dimissController() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Utility Methods
    
    func handleLoginWithSignInProvider(signInProvider: AWSSignInProvider) {
        AWSIdentityManager.defaultIdentityManager().loginWithSignInProvider(signInProvider, completionHandler: {(result: AnyObject?, error: NSError?) -> Void in
            // If no error reported by SignInProvider, discard the sign-in view controller.
            if error == nil {
                dispatch_async(dispatch_get_main_queue(),{
                    self.navigationController!.popViewControllerAnimated(true)
                })
            }
            print("result = \(result), error = \(error)")
        })
    }
    
    func showErrorDialog(loginProviderName: String, withError error: NSError) {
        print("\(loginProviderName) failed to sign in w/ error: \(error)")
        let alertController = UIAlertController(title: NSLocalizedString("Sign-in Provider Sign-In Error", comment: "Sign-in error for sign-in failure."), message: NSLocalizedString("\(loginProviderName) failed to sign in w/ error: \(error)", comment: "Sign-in message structure for sign-in failure."), preferredStyle: .Alert)
        let doneAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Label to cancel sign-in failure."), style: .Cancel, handler: nil)
        alertController.addAction(doneAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - IBActions
    func handleFacebookLogin() {
        handleLoginWithSignInProvider(AWSFacebookSignInProvider.sharedInstance())
    }

}