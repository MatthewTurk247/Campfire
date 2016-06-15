//
//  SignOrLogViewController.swift
//  Campfire
//
//  Created by Matthew Turk on 6/15/16.
//  Copyright © 2016 Turk. All rights reserved.
//

import UIKit
import Firebase

class SignOrLogViewController: UIViewController {
    let myRootRef = Firebase(url:"https://campfireapp.firebaseio.com")
    @IBAction func cancel(sender: AnyObject) {
        print("canel")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        if myRootRef.authData != nil {
            myRootRef.unauth()
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
