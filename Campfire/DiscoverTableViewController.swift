//
//  DiscoverTableViewController.swift
//  Campfire
//
//  Created by Matthew Turk on 6/15/16.
//  Copyright © 2016 Turk. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase
//import Alamofire

class DisoverTableViewController: UITableViewController, MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    
    var searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet var theMapView: MKMapView!
    let manager = LocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.getPermission()
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        stackView.addSubview(searchController.searchBar)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        //self.theMapView.removeFromSuperview()
        //self.navigationController!.view.addSubview(theMapView)
        //        self.tabBarController?.navigationController?.view.addSubview(theMapView)
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let myRootRef = Firebase(url:"https://campfireapp.firebaseio.com")
        // Write data to Firebase
        
        // Read data and react to changes
        myRootRef.observeEventType(.Value, withBlock: {
            snapshot in
            print("\(snapshot.key) -> \(snapshot.value)")
        })
        
        //        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName:UIFont(name: "Futura", size: 20)!]
        //        if (CLLocationManager.locationServicesEnabled()) {
        //            locationManager.delegate = self
        //            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //            locationManager.requestWhenInUseAuthorization()
        //            locationManager.startUpdatingLocation()
        //        } else {
        //            print("Location services are not enabled");
        //        }
        //        let lat:CLLocationDegrees = 41.86438
        //        let long:CLLocationDegrees = -87.628856
        //
        //        let latDelta:CLLocationDegrees = 0.01
        //        let longDelta:CLLocationDegrees = 0.01
        //
        //        let theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        //
        //        let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: long)
        //
        //        let theRegion:MKCoordinateRegion = MKCoordinateRegionMake(location, theSpan)
        //
        //        self.theMapView.setRegion(theRegion, animated: true)
        //
        //        let theLocationPin = MKPointAnnotation()
        //
        //        let pinTitle = "The Location Pin"
        //
        //        let pinSubtitle = "The Location Subtitle"
        //
        //        theLocationPin.coordinate = location
        
        //        var camps = [Camp]()
        //        Alamofire.request(.GET, "http://data.illinois.gov/resource/ge6m-zffc.json", parameters: nil, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) -> Void in
        //            if let JSON = response.result.value {
        //                for camp in (JSON as? NSArray)! {
        //                    camps.append(Camp(titled: camp.objectForKey("camp_name")! as! String))
        //                    //print(camp.objectForKey("camp_name"))
        //                    var coords:NSMutableArray = camp.objectForKey("location1")?.objectForKey("coordinates") as! NSMutableArray
        //                    var annotaion = MKPointAnnotation()
        //                    var lat:Double = coords[0] as! Double
        //                    var lon:Double = coords[1] as! Double
        //                    var aLocation = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        //                    print(aLocation)
        //                }
        //            }
        //        }
        
        //        theLocationPin.title = "\(pinTitle)"
        //        theLocationPin.subtitle = "\(pinSubtitle)"
        //        self.theMapView.addAnnotation(theLocationPin)
        //        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
    //        locationManager.stopUpdatingLocation()
    //        //removeLoadingView()
    //        //        if ((error) != nil) {
    //        //            print(error, terminator: "")
    //        //        }
    //    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        let coord = locationObj.coordinate
        print(coord.latitude)
        print(coord.longitude)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CampCell
        
        
        // Configure the cell..
        return cell
    }
    
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tabBarController?.title = nil
        //        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        //        super.viewWillAppear(animated)
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
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
    }
    
}