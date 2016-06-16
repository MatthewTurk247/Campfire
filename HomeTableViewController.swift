//
//  HomeTableViewController.swift
//  Campfire
//
//  Created by Matthew Turk on 6/15/16.
//  Copyright © 2016 Turk. All rights reserved.
//

import UIKit
import Firebase

class HomeTableViewController: UITableViewController {
    var illinoisCamps:AnyObject!
    let myRootRef = Firebase(url:"https://campfireapp.firebaseio.com")
    let randomColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0)
    let model: [[UIColor]] = [[UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0)]]
    let titles: [[String]] = [["The Palo Alto Unicorns 1", "The Palo Alto Unicorns 2", "The Palo Alto Unicorns 3", "The Palo Alto Unicorns 4", "The Palo Alto Unicorns 5", "The Palo Alto Unicorns 6", "The Palo Alto Unicorns 7", "The Palo Alto Unicorns 8", "The Palo Alto Unicorns 9", "The Palo Alto Unicorns 10", "The Palo Alto Unicorns 11", "The Palo Alto Unicorns 12", "The Palo Alto Unicorns 13", "The Palo Alto Unicorns 14", "The Palo Alto Unicorns 15", "The Palo Alto Unicorns 16"]]
    var illinoisCampTitles: [[String]] = [[], [], [], [], []]
    var storedOffsets = [Int: CGFloat]()
    var tableViewIndexPath = Int()
    @IBOutlet weak var collectionView: UICollectionView!
    //let cats = ["Nearby", "Great Deals", "Popular Camps", "Based On Your Searches", "Like Camps You've Been To"]
    let cats = ["Nearby", "Great Deals", "Popular Camps", "Trending Camps", "Last Minute Offers"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("EWUOIFIOUWEHFIUWENFNOIDKLNDSNVOIDHVIKLS")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.tabBarController?.title = "Home"
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tabBarController?.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        //        myRootRef.observeEventType(.Value, withBlock: {
        //            snapshot in
        //            //print("\(snapshot.key) -> \(snapshot.value)")
        //            let illinoisCamps = snapshot.value.objectForKey("camps")!.objectForKey("us")!.objectForKey("illinois")!
        //            print(illinoisCamps)
        //            //print(firstName)
        //        })
        
    }
    
    override func viewDidAppear(animated: Bool) {
        //self.tabBarController?.navigationController?.navigationBar.viewWithTag(7)?.removeFromSuperview()
        self.tabBarController?.title = "Home"
    }
    
    func setCollectionViewDataSourceDelegate
        <D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>
        (dataSourceDelegate: D, forRow row: Int) {
        
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return cats.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("homeCell", forIndexPath: indexPath) as! CustomTableViewCell
        tableViewIndexPath = indexPath.section
        //cell.collectionView.tag = indexPath.section
        //        print(cell.collectionView.tag)
        print("HELLO: \(indexPath.section)")
        print(cell.collectionView.tag)
        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let tableViewCell = cell as? CustomTableViewCell else { return }
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return cats[section]
    }
    
    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let tableViewCell = cell as? CustomTableViewCell else { return }
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
    
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
    
}

extension HomeTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    //This is where the bodies are buried. 
    
    //I'm thinking its a sectioning index issue -- namcollisions = possibility, conflict with UIKit 
    //Array is too complex -- definitely, so another potential place to look 
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cCell", forIndexPath: indexPath) as! CampCollectionViewCell
        
        myRootRef.observeEventType(.Value, withBlock: {
            snapshot in
            self.illinoisCamps = snapshot.value.objectForKey("camps")!.objectForKey("us")!.objectForKey("illinois")!
            for camp in (self.illinoisCamps as? NSArray)! {
                print(camp.objectForKey("title")!)
                //if camp x - userX < .05 && camp y - userY < .05 the camp is close and append these camps, else just change the header of the cell to Top Camps and append camp after camp from top camps array
                var userX:Float = 40.0
                //user location is enabled {
                if (camp.objectForKey("coordinates")?.objectForKey("x"))! as! Float - userX < 1.5 {
                    print("nearby camp")
                    
                    //append camp
                } //
                //}
                //} else {
                //change cell header to "Top Camps" and for topCamp in topCamps append topCamp
                //}
                //if camp.objectForKey("row") == trending append and stuff only use math for the nearby one
                
                //                self.illinoisCampTitles[0].append(camp.objectForKey("title") as! String + "1")
                //                self.illinoisCampTitles[1].append(camp.objectForKey("title") as! String + "2")
                //                self.illinoisCampTitles[2].append(camp.objectForKey("title") as! String + "3")
                //                self.illinoisCampTitles[3].append(camp.objectForKey("title") as! String + "4")
                //                self.illinoisCampTitles[4].append(camp.objectForKey("title") as! String + "5")
                self.illinoisCampTitles[0].append("1: \(camp.objectForKey("title") as! String)")
                print(self.illinoisCampTitles[0])
                self.illinoisCampTitles[1].append("2: \(camp.objectForKey("title") as! String)")
                self.illinoisCampTitles[2].append("3: \(camp.objectForKey("title") as! String)")
                self.illinoisCampTitles[3].append("4: \(camp.objectForKey("title") as! String)")
                self.illinoisCampTitles[4].append("5: \(camp.objectForKey("title") as! String)")
                print("ENTRO")
                //print("HELLO: \(self.illinoisCampTitles as NSArray)")
            }
            print("HELLO: \(self.illinoisCampTitles)")
            print("HOLA: \(self.illinoisCampTitles[1][0])")
            print(collectionView.tag)
            print(indexPath.item)
            print("First: \(self.tableViewIndexPath)")
            //colletionView.tag is always 0; what can we do to make it 0, 1, 2, 3, 4 like the parent cells
            cell.campLabel.text = self.illinoisCampTitles[self.tableViewIndexPath][indexPath.item]
        })
        
        //Basel says clean this up or face his wrath
        cell.backgroundColor = [[UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0), UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()) , blue: CGFloat(drand48()), alpha: 1.0)]][collectionView.tag][indexPath.item]
        print(collectionView.tag)
        cell.blur.layer.cornerRadius = 5
        cell.blur.clipsToBounds = false
        cell.blur.layer.masksToBounds = false
        cell.campImageView.image = UIImage(named: "unicorn_img")
        print(UIImage(named: "unicorn_img"))
        //cell.campLabel.text = titles[collectionView.tag][indexPath.item]
        print(illinoisCampTitles)
        cell.layer.shadowColor = UIColor.blackColor().CGColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowOpacity = 1.0
        cell.layer.shadowRadius = 2.0
        cell.layer.cornerRadius = 5.0
        cell.clipsToBounds = false
        cell.layer.masksToBounds = false
        
        return cell
    }
}