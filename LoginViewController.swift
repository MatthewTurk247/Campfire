//
//  LoginViewController.swift
//  Campfire
//
//  Created by Matthew Turk on 6/15/16.
//  Copyright © 2016 Turk. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    let myRootRef = Firebase(url:"https://campfireapp.firebaseio.com")
    @IBAction func login(sender: AnyObject) {
        myRootRef.authUser(email.text!, password: password.text!, withCompletionBlock: { error, authData in
            if error != nil {
                // There was an error logging in to this account
            } else {
                // We are now logged in
                print(authData.providerData["email"])
                //                self.navigationController?.presentViewController(MainNav(), animated: true, completion: nil)
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}