//
//  MoreTableViewController.swift
//  Campfire
//
//  Created by Matthew Turk on 6/15/16.
//  Copyright © 2016 Turk. All rights reserved.
//

import UIKit
import Firebase

class MoreTableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let myRootRef = Firebase(url:"https://campfireapp.firebaseio.com")
    let userDataRef = Firebase(url: "https://campfireapp.firebaseio.com/userData")
    @IBOutlet var userLabel: UILabel!
    @IBOutlet var logLabel: UILabel!
    @IBOutlet var userImage: UIImageView!
    var imagePicker = UIImagePickerController()
    @IBAction func uploadImage(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            print("Button capture")
            
            //change status bar color
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    @IBOutlet var switchOne: UISwitch!
    @IBAction func oneSwitched(sender: AnyObject) {
        //        var booleanValue = ["remindersOn": self.switchOne.on]
        //        self.userDataRef.childByAppendingPath(self.myRootRef.authData.uid).childByAppendingPath("remindersOn").setValue(booleanValue)
    }
    @IBOutlet var switchTwo: UISwitch!
    @IBAction func twoSwitched(sender: AnyObject) {
    }
    @IBOutlet var switchThree: UISwitch!
    @IBAction func threeSwitched(sender: AnyObject) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsetsMake(44,0,50,0)
        if myRootRef.authData != nil {
            userLabel.text = String(myRootRef.authData.providerData["email"]!)
            myRootRef.observeEventType(.Value, withBlock: {
                snapshot in
                //print("\(snapshot.key) -> \(snapshot.value)")
                var uid = self.myRootRef.authData.uid
                print("SIUDGHRIUEGIEHGIEURHGIERIUGHEIRUGOSDJVJKDKJDVV")
                print(uid)
                let firstName = snapshot.value.objectForKey("userData")!.objectForKey(uid)!.objectForKey("firstName")!
                let lastName = snapshot.value.objectForKey("userData")!.objectForKey(uid)!.objectForKey("lastName")!
                self.userLabel.text = "\(firstName) \(lastName)"
                //print(firstName)
            })
            var imageURLString:String = myRootRef.authData.providerData["profileImageURL"] as! String!
            
            var imageData = NSData(contentsOfURL: NSURL(string: imageURLString)!)
            //print(myRootRef.authData.providerData["profileImageURL"] as! String!)
            userImage.layer.cornerRadius = userImage.frame.height/2
            userImage.image = UIImage(data: imageData!)
            logLabel.text = "Logout"
        } else {
            logLabel.text = "Login"
            userLabel.text = "Profile"
            userImage.image = UIImage(named: "default")
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tabBarController?.title = "Settings"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if myRootRef.authData == nil {
            return 0
        } else {
            return 3
        }
    }
    //
    //    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete implementation, return the number of rows
    //        return 0
    //    }
    
    /*
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        myRootRef.observeEventType(.Value, withBlock: {
            snapshot in
            
            })
        userImage.clipsToBounds = true
        userImage.layer.cornerRadius = userImage.frame.height/2
        
        //change users image
        //usersimage = image
    }
}