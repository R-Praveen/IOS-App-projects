//
//  SearchBarController.swift
//  ProductListing
//
//  Created by Praveen Ramalingam on 20/02/23.
//

import Foundation
import UIKit

class AppBarController : UIViewController, UISearchBarDelegate {
    private var searchBar: UISearchBar = UISearchBar()
    private var exploreLabel: UILabel = UILabel()
    private var filterLabel: UILabel = UILabel()
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        print(searchBar.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Visual properties of root view
        view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 220)
        view.backgroundColor = UIColor(named: "AppBarBackgroundColor")
        // properties of filterLabel
        setAppFilterProperties()
        // properties of exploreLabel
        setAppExploreProperties()
        // properties of searchBar
        setSearchBarProperties()
        
        // Adding views to subview
        view.addSubview(searchBar)
        view.addSubview(exploreLabel)
        view.addSubview(filterLabel)
        
        // Adding contstraints for the view
        setContraints()
    }
    
    //MARK: Setting the app filter properties
    func setAppFilterProperties(){
        filterLabel.text = AppStrings.filter
        filterLabel.font = UIFont.systemFont(ofSize: 16)
        filterLabel.textColor = UIColor(named: "filterLabelColor")
    }
    
    //MARK: Setting the app explore properties
    func setAppExploreProperties(){
        exploreLabel.text = AppStrings.explore
        exploreLabel.textColor = .black
        exploreLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    //MARK: Setting the properties of the search bar in the Appbar
    func setSearchBarProperties(){
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 0))
        searchBar.delegate = self
        searchBar.searchTextField.backgroundColor = UIColor.clear
        searchBar.layer.cornerRadius = 20
        searchBar.placeholder = AppStrings.search
        searchBar.backgroundColor = UIColor.white
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.setImage(UIImage(), for: .search, state: .normal)
    }
    
    //MARK: Setting the constraints explore ,filter searchbar
    func setContraints(){
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        exploreLabel.translatesAutoresizingMaskIntoConstraints = false
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //Explore label contraints
        exploreLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 35).isActive = true
        exploreLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        exploreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        //Filter Label Constraints
        filterLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 35).isActive = true
        filterLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        filterLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        filterLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30).isActive = true
        
        //SearchBar Constraints
        searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        searchBar.widthAnchor.constraint(equalToConstant: 40).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -10).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30).isActive = true

    }
}
