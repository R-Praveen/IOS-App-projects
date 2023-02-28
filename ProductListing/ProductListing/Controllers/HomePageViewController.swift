//
//  ViewController.swift
//  ProductListing
//
//  Created by Praveen Ramalingam on 14/02/23.
//

import UIKit

class HomePageViewController: UITabBarController, AppBarControllerDelegate {
    let selectedColor = UIColor.gray
    let deselectedColor = UIColor.gray
    var appBarController = AppBarController()
    //Properties for all the tab bars
    let tabOne = ListViewController()
    let tabTwo = GridViewController()
    let tabThree = EmptyPageController()
    let tabFour = EmptyPageController()
    let tabFive = EmptyPageController()

    let searchUtils = SearchUtils(viewModel: ViewModel(networkService: NetworkService(), coreDataHelper: CoreDataHelper(managedObjectContext: CoreDataStack.shared.mainContext)))
    
    let tabBarImage = UIImage(named: "TabBarIconImage")
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.delegate = self
        tabBar.itemWidth = 76
        tabBar.isTranslucent = true
        appBarController.appBarControllerDelegate = self
        view.backgroundColor = .white
        view.addSubview(appBarController.view)
        
        setUpControllers()
        
        self.selectPage(at: 0)
    }
    
    //Setting up the tab bar item.
    private func tabbarItem() -> UITabBarItem {
        let tabBarItem = UITabBarItem(title: nil, image: tabBarImage, selectedImage: nil)
        tabBarItem.imageInsets = UIEdgeInsets(top: 8.5, left: 0, bottom: -8.5, right: 0)
        return tabBarItem
    }
    
    //MARK: Setting up the controllers of the tabs
    private func setUpControllers(){
        guard let centerPageViewController = createCenterPageViewController() else { return }
        
        var controllers: [UIViewController] = []
        
        controllers.append(createPlaceholderViewController(forIndex: 0))
        controllers.append(centerPageViewController)
        controllers.append(createPlaceholderViewController(forIndex: 2))
        controllers.append(createPlaceholderViewController(forIndex: 3))
        controllers.append(createPlaceholderViewController(forIndex: 4))
       
        
        setViewControllers(controllers, animated: false)
        
        selectedViewController = centerPageViewController
    }
    
    //MARK: Listening to search bar and updating the search results
    func onTextChanged(text: String) {
        let items = searchUtils.searchItems(text: text)
        tabOne.updateTableViewSearchResults(storeItems: items)
        tabTwo.updateTableViewSearchResults(storeItems: items)
    }
    
    //MARK: Creating the current page controller
    private func createCenterPageViewController() -> UIPageViewController? {
        tabOne.view.tag = 0
        tabTwo.view.tag = 1
        tabThree.view.tag = 2
        tabFour.view.tag = 3
        tabFive.view.tag = 4
        let pageViewController = PageViewController()
        
        pageViewController.pages = [tabOne, tabTwo,tabThree,tabFour,tabFive]
        pageViewController.tabBarItem = tabbarItem()
        pageViewController.view.tag = 1
        pageViewController.swipeDelegate = self
        
        return pageViewController
    }
    
    //MARK: Controls the selection of page based on index
    private func selectPage(at index: Int) {
        guard let viewController = self.viewControllers?[index] else { return }
        self.handleTabbarItemChange(viewController: viewController)
        guard let PageViewController = (self.viewControllers?[1] as? PageViewController) else { return }
        PageViewController.selectPage(at: index)
    }
    
    //MARK: Creating the placeholder view for the tab
    private func createPlaceholderViewController(forIndex index: Int) -> UIViewController {
        let emptyViewController = UIViewController()
        emptyViewController.tabBarItem = tabbarItem()
        emptyViewController.view.tag = index
        return emptyViewController
    }
    
    //MARK: Listening to the tab bar item change.
    private func handleTabbarItemChange(viewController: UIViewController) {
        guard let viewControllers = self.viewControllers else { return }
        let selectedIndex = viewController.view.tag
        self.tabBar.tintColor = selectedColor
        self.tabBar.unselectedItemTintColor = selectedColor
        
        
        for i in 0..<viewControllers.count {
            let tabbarItem = viewControllers[i].tabBarItem
            let tabbarImage = self.tabBarImage
            tabbarItem?.selectedImage = tabbarImage!.withRenderingMode(.alwaysTemplate)
            tabbarItem?.image = tabbarImage!.withRenderingMode(
                i == selectedIndex ? .alwaysOriginal : .alwaysTemplate
            )
        }
        
        if selectedIndex == 1 {
            viewControllers[selectedIndex].tabBarItem.selectedImage = self.tabBarImage!.withRenderingMode(.alwaysOriginal)
        }
    }
}

//Extension for the UITabBarControler delegate
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
