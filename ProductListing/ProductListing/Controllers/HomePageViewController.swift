//
//  ViewController.swift
//  ProductListing
//
//  Created by Praveen Ramalingam on 14/02/23.
//

import UIKit

class HomePageViewController: UITabBarController {
    let selectedColor = UIColor.blue
    let deselectedColor = UIColor.gray
    
    let tabBarNames = [
      "List",
      "Grid",
    ]
    
    let tabBarImages = [
        UIImage(systemName: "list.bullet.rectangle"),
        UIImage(systemName: "square.grid.2x2")
    ]
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.delegate = self
        tabBar.isTranslucent = true
        tabBar.tintColor = deselectedColor
        tabBar.unselectedItemTintColor = deselectedColor
        tabBar.barTintColor = UIColor.white.withAlphaComponent(0.92)
        tabBar.itemSpacing = 10.0
        tabBar.itemWidth = 76.0
        tabBar.itemPositioning = .centered
        
        setUpControllers()
        
        self.selectPage(at: 0)
    }
    
    private func tabbarItem(at index: Int) -> UITabBarItem {
        return UITabBarItem(title: nil, image: self.tabBarImages[index], selectedImage: nil)
    }
    
    private func setUpControllers(){
        guard let centerPageViewController = createCenterPageViewController() else { return }
        
        var controllers: [UIViewController] = []
        
        controllers.append(createPlaceholderViewController(forIndex: 0))
        controllers.append(centerPageViewController)
        
        setViewControllers(controllers, animated: false)
        
        selectedViewController = centerPageViewController
    }
    
    private func createCenterPageViewController() -> UIPageViewController? {
        
        let leftController = ListViewController()
        let rightController = GridViewController()
        
        leftController.view.tag = 0
        rightController.view.tag = 1
                
        let pageViewController = PageViewController()
        
        pageViewController.pages = [leftController, rightController]
        pageViewController.tabBarItem = tabbarItem(at: 1)
        pageViewController.view.tag = 1
        pageViewController.swipeDelegate = self
        
        return pageViewController
    }
    
    private func selectPage(at index: Int) {
        guard let viewController = self.viewControllers?[index] else { return }
        self.handleTabbarItemChange(viewController: viewController)
        guard let PageViewController = (self.viewControllers?[1] as? PageViewController) else { return }
        PageViewController.selectPage(at: index)
    }
    
    private func createPlaceholderViewController(forIndex index: Int) -> UIViewController {
        let emptyViewController = UIViewController()
        emptyViewController.tabBarItem = tabbarItem(at: index)
        emptyViewController.view.tag = index
        return emptyViewController
    }
    
    private func handleTabbarItemChange(viewController: UIViewController) {
        guard let viewControllers = self.viewControllers else { return }
        let selectedIndex = viewController.view.tag
        self.tabBar.tintColor = selectedColor
        self.tabBar.unselectedItemTintColor = selectedColor
        
        for i in 0..<viewControllers.count {
            let tabbarItem = viewControllers[i].tabBarItem
            let tabbarImage = self.tabBarImages[i]
            tabbarItem?.selectedImage = tabbarImage!.withRenderingMode(.alwaysTemplate)
            tabbarItem?.image = tabbarImage!.withRenderingMode(
                i == selectedIndex ? .alwaysOriginal : .alwaysTemplate
            )
        }
        
        if selectedIndex == 0 {
            viewControllers[selectedIndex].tabBarItem.selectedImage = self.tabBarImages[0]!.withRenderingMode(.alwaysOriginal)
        }
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

extension HomePageViewController: UITabBarControllerDelegate,PageViewControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        self.selectPage(at: viewController.view.tag)
        return false
    }
    func pageDidSwipe(to index: Int) {
        guard let viewController = self.viewControllers?[index] else { return }
        self.handleTabbarItemChange(viewController: viewController)
    }
}
