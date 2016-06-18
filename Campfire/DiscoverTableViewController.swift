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
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet var theMapView: MKMapView!
    var illinoisCamps:AnyObject!
    var center = CLLocation(latitude: 37.7832889, longitude: -122.4056973)
    var long = Double()
    var lat = Double()
    let myRootRef = Firebase(url:"https://campfireapp.firebaseio.com")
    let coreLocationManager = CLLocationManager()
    var locationManager = LocationManager.sharedInstance
    var geoFire = GeoFire(firebaseRef: Firebase(url: "campfireapp.firebaseio.com"))
    override func viewDidLoad() {
        super.viewDidLoad()
        //this is the only getLocation() that currently works
        getLocation()
        //if location is disabled just have image there saying "We need you to turn on location access in settings first (emoji)"
        
        coreLocationManager.delegate = self
        
        locationManager = LocationManager.sharedInstance
        
        let authorizationCode = CLLocationManager.authorizationStatus()
        
        if authorizationCode == CLAuthorizationStatus.NotDetermined && coreLocationManager.respondsToSelector("requestAlwaysAuthorization") || coreLocationManager.respondsToSelector("requestWhenInUseAuthorization"){
            if NSBundle.mainBundle().objectForInfoDictionaryKey("NSLocationAlwaysUsageDescription") != nil {
                coreLocationManager.requestAlwaysAuthorization()
            }else{
                print("No descirption provided")
            }
        }else{
            getLocation()
        }
        
    }
    
    func createSearchBar() {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Search America For Camps"
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        searchBar.tintColor = UIColor.whiteColor()
        self.tabBarController?.navigationItem.titleView = searchBar
    }
    
    func getLocation(){
        print("getting")
        locationManager.startUpdatingLocationWithCompletionHandler { (latitude, longitude, status, verboseMessage, error) -> () in
            self.displayLocation(CLLocation(latitude: latitude, longitude: longitude))
        }
        
    }
    
    func displayLocation(location:CLLocation) {
        print("displaying: \(location.coordinate)")
        print(location.coordinate.latitude, location.coordinate.longitude)
        theMapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude), span: MKCoordinateSpanMake(1.0, 1.0)), animated: true)
        
        let locationPinCoord = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationPinCoord
        
        //theMapView.addAnnotation(annotation)
        //theMapView.showAnnotations([annotation], animated: true)
        
        myRootRef.observeEventType(.Value, withBlock: {
            snapshot in
            
            
            self.illinoisCamps = snapshot.value.objectForKey("camps")!.objectForKey("us")!.objectForKey("illinois")!
            for camp in (self.illinoisCamps as? NSArray)! {
                //this is where you would set the x and y of iterating illinois camps and the key should be the title object for key
                //here lat will be the lat of the camp object for key and for key will be the camp name
                self.geoFire.setLocation(CLLocation(latitude: camp.objectForKey("coordinates")!.objectForKey("x") as! Double, longitude: camp.objectForKey("coordinates")!.objectForKey("y") as! Double), forKey: camp.objectForKey("title") as! String) { (error) in
                    if (error != nil) {
                        print("An error occured: \(error)")
                    } else {
                        print("Saved location successfully: \(CLLocation(latitude: camp.objectForKey("coordinates")!.objectForKey("x") as! Double, longitude: camp.objectForKey("coordinates")!.objectForKey("y") as! Double))")
                    }
                }
            }
        })
        
        var circleQuery = self.geoFire.queryAtLocation(location, withRadius: 160.9344)
        var queryHandle = circleQuery.observeEventType(.KeyEntered, withBlock: { (key: String!, location: CLLocation!) in
            print("Key '\(key)' entered the search area and is at location '\(location)'")
            var pin = MKPointAnnotation()
            pin.title = key
            pin.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            self.theMapView.addAnnotation(pin)
        })
        
        locationManager.reverseGeocodeLocationWithCoordinates(location, onReverseGeocodingCompletionHandler: { (reverseGecodeInfo, placemark, error) -> Void in
            
            let address = reverseGecodeInfo?.objectForKey("formattedAddress") as! String
            print(address)
            //self.locationInfo.text = address
            
        })
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CampCell
        //print(nearbyCampTitles)
        //print("Here", theMapView.annotations[0].title)
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
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        
        var region = MKCoordinateRegion()
        region.center = mapView.userLocation.coordinate
        region.span.latitudeDelta = 0.01
        region.span.longitudeDelta = 0.01
        
        mapView.setRegion(region, animated: true)
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