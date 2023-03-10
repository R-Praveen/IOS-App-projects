//
//  GridViewController.swift
//  ProductListing
//
//  Created by Praveen Ramalingam on 16/02/23.
//

import UIKit

class GridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private var response: Response?
    private var gridView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    var viewModel = ViewModel(networkService: NetworkService(), coreDataHelper: CoreDataHelper(managedObjectContext: CoreDataStack.shared.mainContext))
    var loader = LoaderView()
    private var pullToRefresh = UIRefreshControl()
    var items: [StoreItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gridView.delegate = self
        gridView.dataSource = self
        view.backgroundColor = .systemBackground
        addSubViews()
        setContraints()
        gridView.refreshControl = pullToRefresh
        gridView.register(UIGridViewCell.self, forCellWithReuseIdentifier: UIGridViewCell.identifier)
        pullToRefresh.addTarget(self, action: #selector(handlePullToRefresh), for: .valueChanged)
        gridView.contentSize = CGSize(width: 100, height: 100)
        fetchItems()
    }
    
    @objc func handlePullToRefresh(){
        fetchItems()
        pullToRefresh.endRefreshing()
    }
    
    //MARK: Adding the sub views for the Grid view
    func addSubViews(){
        loader = LoaderView(frame: view.frame)
        view.addSubview(gridView)
    }
    
    //Updates the table view search results
    func updateTableViewSearchResults(storeItems: [StoreItem]){
        self.items = storeItems
        gridView.reloadData()
    }
    
    
    //MARK: Setting the constraints for the APP bar and the grid view
    func setContraints(){
        gridView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            //Grid View constraints
            gridView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gridView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            gridView.widthAnchor.constraint(equalTo: view.widthAnchor),
            gridView.topAnchor.constraint(equalTo: view.topAnchor,constant: 190),
            gridView.heightAnchor.constraint(equalTo: view.heightAnchor,constant: -170),
            gridView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10),
            gridView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            gridView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: 10),
        ]
        )
    }
    
    //MARK: Fetching the items for the grid view from view model
    func fetchItems(){
        if !pullToRefresh.isRefreshing {
            loader.startLoading(view: view)
        }
        viewModel.getItems(callback: {storeItems in
            self.items = storeItems
            DispatchQueue.main.async {
                if !self.pullToRefresh.isRefreshing {
                    self.loader.stopLoading(view: self.view)
                }
                self.gridView.reloadData()
                if self.pullToRefresh.isRefreshing {
                    self.pullToRefresh.endRefreshing()
                }
            }
        })
    }
    
    //MARK: Builds of items in the collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    //MARK: Configures the individual cell in the Collection View
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gridView.dequeueReusableCell(withReuseIdentifier: UIGridViewCell.identifier, for: indexPath) as! UIGridViewCell
        let item = items?[indexPath.row]
        cell.configureTitle(titleLabel: item?.name ?? "")
        cell.configureSubtitle(subtitleLabel: item?.price ?? "")
        cell.configureImageView(image: item?.image ?? "")

        return cell
    }
    
    //MARK: Building the width and height of the collection view layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width/3)-3, height: (view.frame.size.width/3)-3)
    }
    
    
    //MARK: Setting the inter item spacing between the cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    //MARK: Setting the line spacing for the section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
}
