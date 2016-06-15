//
//  SignUpViewController.swift
//  Campfire
//
//  Created by Matthew Turk on 6/15/16.
//  Copyright © 2016 Turk. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    let myRootRef = Firebase(url:"https://campfireapp.firebaseio.com")
    let userDataRef = Firebase(url: "https://campfireapp.firebaseio.com/userData")
    @IBAction func signUp(sender: AnyObject) {
        if email.text != nil {
            myRootRef.createUser(email.text!, password: password.text!,
                                 withValueCompletionBlock: { error, result in
                                    if error != nil {
                                        // There was an error creating the account
                                    } else {
                                        let uid = result["uid"] as? String
                                        print("Successfully created user account with uid: \(uid)")
                                        let firstName = ["firstName": self.firstName.text!]
                                        let lastName = ["lastName": self.lastName.text!]
                                        self.userDataRef.childByAppendingPath(uid).setValue(firstName)
                                        self.userDataRef.childByAppendingPath(uid).setValue(lastName)
                                        self.presentViewController(CampTabBarController(), animated: true, completion: nil)
                                    }
            })
        }
    }
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
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