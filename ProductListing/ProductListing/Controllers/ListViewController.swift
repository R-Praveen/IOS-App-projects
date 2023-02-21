//
//  ListViewController.swift
//  ProductListing
//
//  Created by Praveen Ramalingam on 16/02/23.
//

import UIKit

class ListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var response: Response?
    var items: [StoreItem]?
    
    //MARK: Private Properties
    private var tableView = UITableView()
    private var searchTitle = UILabel()
    private var searchBar = UISearchBar()
    
    var viewModel : ViewModel?
    var appBarView = AppBarController().view
    var loader = LoaderView()

    //MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        viewModel = ViewModel()
        addSubViews()
        setContraints()
        setTableViewValues()
        fetchItems()
    }
    
    //MARK: Adding the subviews
    func addSubViews(){
        loader = LoaderView(frame: view.frame)
        view.addSubview(appBarView!)
        view.addSubview(tableView)
    }
    
    //MARK: Setting the table view values and registering the cell for the table view , setting the row height
    func setTableViewValues(){
        tableView.register(ItemCellTableViewCell.self, forCellReuseIdentifier: ItemCellTableViewCell.identifier)
        tableView.rowHeight = 100
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: Fetching the items to be shown in the table view
    func fetchItems(){
        loader.startLoading(view: view)
        viewModel!.getItems(callback: {storeItems in
            self.items = storeItems
            DispatchQueue.main.async {
                self.loader.stopLoading(view: self.view)
                self.tableView.reloadData()
            }
        })
    }
    
    
    //MARK: Depicts the number of items in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    //MARK: Builds the individual cell of the table View
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemCellTableViewCell.identifier, for: indexPath) as! ItemCellTableViewCell
        let item = items?[indexPath.row]
        cell.configureImageView(image: item?.image ?? "")
        cell.configureTitle(title: item?.name ?? "")
        cell.configureSubtitle(subtitle: item?.price ?? "")
        cell.configureSameDayShipping(shippingDay: item?.extra ?? "")
        return cell
    }
    
    //MARK: Setting the constraints for the appbar and the tableview
    func setContraints(){
        appBarView!.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            //App bar constraints
            appBarView!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appBarView!.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            appBarView!.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            appBarView!.heightAnchor.constraint(equalToConstant: 80),
            appBarView!.topAnchor.constraint(equalTo: view.topAnchor),
            appBarView!.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            appBarView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            appBarView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            //Table View constraints
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor,constant: -appBarView!.frame.size.height),
            tableView.topAnchor.constraint(equalTo: appBarView!.bottomAnchor,constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ]
        )
    }
}
