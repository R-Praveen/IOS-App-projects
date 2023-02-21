//
//  ViewController.swift
//  ProductListing
//
//  Created by Praveen Ramalingam on 14/02/23.
//

import UIKit

class HomePageViewController: UITabBarController {
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        configuringTabs()
    }
    
    //This method configures the tabs of the home page
    func configuringTabs(){
        let tabOne = UINavigationController(rootViewController: ListViewController())
        let tabTwo = UINavigationController(rootViewController: GridViewController())
        tabOne.tabBarItem.image = UIImage(systemName: "list.bullet.rectangle")
        tabOne.tabBarItem.title = "List"
        tabTwo.tabBarItem.image = UIImage(systemName: "square.grid.2x2")
        tabTwo.tabBarItem.title = "Grid"
        setViewControllers([tabOne,tabTwo], animated: true)
    }
}

