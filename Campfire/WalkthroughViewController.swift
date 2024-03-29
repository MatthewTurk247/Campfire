//
//  WalkthroughViewController.swift
//  Campfire
//
//  Created by Matthew Turk on 6/16/16.
//  Copyright © 2016 Turk. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController {
    
    // These IBOutlets are already connect for you. We'll configure these outlets later
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    
    // MARK: - Data model for each walkthrough screen
    var index = 0               // the current page index
    var headerText = ""
    var imageName = ""
    var descriptionText = ""
    
    // Just to make sure that the status bar is white - it depends on your preference
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // 1 - Let's configure a walkthrough screen with the data model
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel.text = headerText
        descriptionLabel.text = descriptionText
        imageView.image = UIImage(named: imageName)
        pageControl.currentPage = index
        
        // customize the next and start button
        startButton.hidden = (index == 3) ? false : true
        nextButton.hidden = (index == 3) ? true : false
        startButton.layer.cornerRadius = 5.0
        startButton.layer.masksToBounds = true
    }
    
    // 2-  if the user click the start button, we will just dismiss the page VC as we are displaying this PageVC via a modal segue
    
    @IBAction func startClicked(sender: AnyObject) {
        // we're good with the walk through.
        // also, don't forget to update userdefaults
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(true, forKey: "DisplayedWalkthrough")
        
        // but wait, how did you know that we displayed the PageVC via a modal segue? We didn't! Let's display the PageVC before doing anything else
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // if the user clicks the next button, we'll show the next page view controller
    
    @IBAction func nextClicked(sender: AnyObject) {
        let pageViewController = self.parentViewController as! PageViewController
        pageViewController.nextPageWithIndex(index)
    }
}