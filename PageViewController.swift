//
//  PageViewController.swift
//  Campfire
//
//  Created by Matthew Turk on 6/16/16.
//  Copyright © 2016 Turk. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    // Some hard-coded data for our walkthrough screens
    var pageHeaders = ["Learn to Design iOS Apps", "Create Prototypes", "Develop Animation", "Social Networks with Parse"]
    var pageImages = ["app1", "app2", "app3", "app4"]
    var pageDescriptions = ["Learn to design the world's most beautiful iOS apps without having to hire a designer.", "Validate your app idea by creating a prototype before implementation", "Delight your users with stunning animation and transition", "Connect people together!"]
    
    // make the status bar white (light content)
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // this class is the page view controller's data source itself
        self.dataSource = self
        
        // create the first walkthrough vc
        if let startWalkthroughVC = self.viewControllerAtIndex(0) {
            setViewControllers([startWalkthroughVC], direction: .Forward, animated: true, completion: nil)
        }
        
    }
    
    // MARK: - Navigate
    
    func nextPageWithIndex(index: Int) {
        if let nextWalkthroughVC = self.viewControllerAtIndex(index+1) {
            setViewControllers([nextWalkthroughVC], direction: .Forward, animated: true, completion: nil)
        }
    }
    
    func viewControllerAtIndex(index: Int) -> WalkthroughViewController? {
        if index == NSNotFound || index < 0 || index >= self.pageDescriptions.count {
            return nil
        }
        
        // create a new walkthrough view controller and assing appropriate date
        if let walkthroughViewController = storyboard?.instantiateViewControllerWithIdentifier("WalkthroughViewController") as? WalkthroughViewController {
            walkthroughViewController.imageName = pageImages[index]
            walkthroughViewController.headerText = pageHeaders[index]
            walkthroughViewController.descriptionText = pageDescriptions[index]
            walkthroughViewController.index = index
            
            return walkthroughViewController
        }
        
        return nil
    }
}

extension PageViewController : UIPageViewControllerDataSource {
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! WalkthroughViewController).index
        index++
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughViewController).index
        index--
        return self.viewControllerAtIndex(index)
    }
}