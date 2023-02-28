//
//  SearchBarController.swift
//  ProductListing
//
//  Created by Praveen Ramalingam on 20/02/23.
//

import Foundation
import UIKit

//Protocol to listen to the text change on the App bar search field.
protocol AppBarControllerDelegate{
    func onTextChanged(text: String)
}

//MARK: App bar for all the entire tab bars.
class AppBarController : UIViewController, UISearchBarDelegate  {
    var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.isTranslucent = false
        searchBar.barTintColor = .white
        searchBar.layoutIfNeeded()
        return searchBar
    }()
    private var exploreLabel: UILabel = UILabel()
    private var filterLabel: UILabel = UILabel()
    private var firstRow = UIView()
    
    var appBarControllerDelegate: AppBarControllerDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        appBarControllerDelegate?.onTextChanged(text: textSearched)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Visual properties of root view
        view.backgroundColor = UIColor(named: "AppBarBackgroundColor")
        // properties of filterLabel
        setAppFilterProperties()
        // properties of exploreLabel
        setAppExploreProperties()
        // properties of searchBar
        setSearchBarProperties()
        // Adding views to subview
        view.addSubview(firstRow)
        view.addSubview(searchBar)
        view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 170)
        firstRow.addSubview(exploreLabel)
        firstRow.addSubview(filterLabel)
        
        // Adding contstraints for the view
        setFirstRowConstraints()
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
        searchBar.searchTextField.backgroundColor = UIColor.clear
        searchBar.layer.cornerRadius = 25
        searchBar.barStyle = .black
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = .white
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.setImage(UIImage(), for: .search, state: .normal)
    }
    
    
    func setFirstRowConstraints(){
        firstRow.translatesAutoresizingMaskIntoConstraints = false
        firstRow.topAnchor.constraint(equalTo: view.topAnchor,constant: 35).isActive = true
        firstRow.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34).isActive = true
        firstRow.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34).isActive = true
    }
    
    //MARK: Setting the constraints explore ,filter searchbar
    func setContraints(){
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        exploreLabel.translatesAutoresizingMaskIntoConstraints = false
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //Explore label contraints
        exploreLabel.topAnchor.constraint(equalTo: firstRow.topAnchor,constant: 20).isActive = true
        exploreLabel.leadingAnchor.constraint(equalTo: firstRow.leadingAnchor,constant: 10).isActive = true
        exploreLabel.bottomAnchor.constraint(equalTo: firstRow.bottomAnchor).isActive = true
        
        //Filter Label Constraints
        filterLabel.topAnchor.constraint(equalTo: firstRow.topAnchor,constant: 20).isActive = true
        filterLabel.trailingAnchor.constraint(equalTo: firstRow.trailingAnchor).isActive = true
        filterLabel.bottomAnchor.constraint(equalTo: firstRow.bottomAnchor).isActive = true
        
        //SearchBar Constraints
        searchBar.topAnchor.constraint(equalTo: firstRow.bottomAnchor,constant: 15).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 34).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -34).isActive = true
        
    }
}
