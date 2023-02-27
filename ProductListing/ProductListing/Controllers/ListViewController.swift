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
    private var appBar = UIView()
    private var pullToRefresh = UIRefreshControl()
    
    var viewModel : ViewModel?
    var loader = LoaderView()
    
    //MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        viewModel = ViewModel(networkService: NetworkService(), coreDataHelper: CoreDataHelper(managedObjectContext: CoreDataStack.shared.mainContext))
        addSubViews()
        setContraints()
        setTableViewValues()
        fetchItems()
        tableView.refreshControl = pullToRefresh
        pullToRefresh.addTarget(self, action: #selector(handlePullToRefresh), for: .valueChanged)
    }
    
    @objc func handlePullToRefresh(){
        fetchItems()
        pullToRefresh.endRefreshing()
    }
    
    //MARK: Adding the subviews
    func addSubViews(){
        loader = LoaderView(frame: view.frame)
        view.addSubview(tableView)
    }
    
    func updateTableViewSearchResults(storeItems: [StoreItem]){
        self.items = storeItems
        tableView.reloadData()
    }
    
    //MARK: Setting the table view values and registering the cell for the table view , setting the row height
    func setTableViewValues(){
        tableView.register(ItemCellTableViewCell.self, forCellReuseIdentifier: ItemCellTableViewCell.identifier)
        tableView.rowHeight = 80
        
        tableView.delegate = self
        tableView.dataSource = self
    }
     
    //MARK: Fetching the items to be shown in the table view
    func fetchItems(){
        if !pullToRefresh.isRefreshing {
            loader.startLoading(view: view)
        }
        viewModel!.getItems(callback: {storeItems in
            self.items = storeItems
            DispatchQueue.main.async {
                if !self.pullToRefresh.isRefreshing {
                    self.loader.stopLoading(view: self.view)
                }
                self.tableView.reloadData()
                if self.pullToRefresh.isRefreshing {
                    self.pullToRefresh.endRefreshing()
                }
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
        cell.configuretitleLabel(titleLabel: item?.name ?? "")
        cell.configuresubtitleLabel(subtitleLabel: item?.price ?? "")
        cell.configuremrpLabel()
        cell.configuresameDayShippingLabel(shippingDay: item?.extra ?? "")
        return cell
    }
    //MARK: Setting the constraints for the appbar and the tableview
    func setContraints(){
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            //Table View constraints
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor,constant: 190),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor,constant: -170),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        )
    }
}
