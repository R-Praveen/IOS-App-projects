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
    var viewModel = ViewModel()
    var loader = LoaderView()
    var items: [StoreItem]?
    
    var appBarView = AppBarController().view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gridView.delegate = self
        gridView.dataSource = self
        view.backgroundColor = .systemBackground
        addSubViews()
        setContraints()
        gridView.register(UIGridViewCell.self, forCellWithReuseIdentifier: UIGridViewCell.identifier)
        gridView.contentSize = CGSize(width: 100, height: 100)
        fetchItems()
    }
    
    //MARK: Adding the sub views for the Grid view
    func addSubViews(){
        loader = LoaderView(frame: view.frame)
        view.addSubview(appBarView!)
        view.addSubview(gridView)
    }
    
    //MARK: Setting the constraints for the APP bar and the grid view
    func setContraints(){
        appBarView!.translatesAutoresizingMaskIntoConstraints = false
        gridView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            //App bar constraints
            appBarView!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appBarView!.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            appBarView!.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            appBarView!.heightAnchor.constraint(equalToConstant: 80),
            appBarView!.topAnchor.constraint(equalTo: view.topAnchor),
            appBarView!.bottomAnchor.constraint(equalTo: gridView.topAnchor),
            appBarView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            appBarView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            //Grid View constraints
            gridView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gridView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            gridView.widthAnchor.constraint(equalTo: view.widthAnchor),
            gridView.heightAnchor.constraint(equalTo: view.heightAnchor,constant: -appBarView!.frame.size.height),
            gridView.topAnchor.constraint(equalTo: appBarView!.bottomAnchor,constant: -10),
            gridView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10),
            gridView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            gridView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ]
        )
    }
    
    //MARK: Fetching the items for the grid view from view model
    func fetchItems(){
        loader.startLoading(view: view)
        viewModel.getItems(callback: {storeItems in
            self.items = storeItems
            DispatchQueue.main.async {
                self.loader.stopLoading(view: self.view)
                self.gridView.reloadData()
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
        cell.configureTitle(title: item?.name ?? "")
        cell.configureSubtitle(subtitle: item?.price ?? "")
        cell.configureImageView(image: item?.image ?? "")

        return cell
    }
    
    //MARK: Building the width and height of the collection view layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width/3)-3, height: (view.frame.size.width/3)-3)
    }
    
    
    //MARK: Setting the inter item spacing between the cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    //MARK: Setting the line spacing for the section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
}
