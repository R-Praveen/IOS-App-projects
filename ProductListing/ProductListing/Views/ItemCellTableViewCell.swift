//
//  ItemCellTableViewCell.swift
//  ProductListing
//
//  Created by Praveen Ramalingam on 17/02/23.
//

import UIKit

class ItemCellTableViewCell: UITableViewCell {
    static let identifier = "CustomTableViewCell"
    
    var itemImage = UIImageView()
    var title = UILabel()
    var subtitle = UILabel()
    var mrp = UILabel()
    var sameDayShipping = UILabel()
    var lineView = UIView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(itemImage)
        addSubview(title)
        addSubview(subtitle)
        addSubview(sameDayShipping)
        addSubview(lineView)

        
        configureLineView()
        
        setImageConstraints()
        setTitleConstraints()
        setSubtitleConstraints()
        setSameDayShippingConstraints()
        setLineViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Configuring the image corner radius
    public func configureImageView(image: String?){
        itemImage.layer.cornerRadius = 10
        downloadImage(from: URL(string:image!)!)
    }
    
    //MARK: Download the image to be shown in the view
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.itemImage.image = UIImage(data: data)
            }
        }
    }
    
    //MARK: getting the data of the image
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    //MARK: Configuring the title properties
    func configureTitle(title: String){
        self.title.text = title
        self.title.adjustsFontSizeToFitWidth = true
        self.title.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        self.title.textColor = UIColor.black
    }
    
    //MARK: Configuring the subtitle properties
    func configureSubtitle(subtitle: String){
        self.subtitle.text = subtitle
        self.subtitle.adjustsFontSizeToFitWidth = true
        self.subtitle.font = UIFont.systemFont(ofSize: 14, weight: .light)
        self.subtitle.textColor = UIColor.black
    }
    
    //MARK: Configuring the same day shipping properties
    func configureSameDayShipping(shippingDay: String?){
        self.sameDayShipping.text = shippingDay
        self.sameDayShipping.adjustsFontSizeToFitWidth = true
        self.sameDayShipping.font = sameDayShipping.font.withSize(16)
        self.sameDayShipping.textColor = UIColor.lightGray
        
    }
    
    //MARK: Configuring the line view
    func configureLineView(){
        lineView.layer.borderWidth = 0.5
        lineView.layer.borderColor = UIColor(named: "dividerColor")?.cgColor
    }
    
    //MARK: Configuring the image constraints
    func setImageConstraints(){
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        itemImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        itemImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        itemImage.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        itemImage.widthAnchor.constraint(equalTo: itemImage.heightAnchor).isActive = true
        itemImage.clipsToBounds = true
    }
    
    //MARK: Configuring the title constraints
    func setTitleConstraints(){
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor,constant: 10).isActive = true
        title.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        title.heightAnchor.constraint(equalToConstant: 30).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -12).isActive = true
    }
    
    //MARK: Configuring the MRP constraints
    func setMRPConstraints(){
        mrp.translatesAutoresizingMaskIntoConstraints = false
        mrp.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor,constant: 10).isActive = true
        mrp.topAnchor.constraint(equalTo: title.bottomAnchor,constant: 2).isActive = true
        mrp.heightAnchor.constraint(equalToConstant: 20).isActive = true
        mrp.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -12).isActive = true
    }
    
    //MARK: Configuring the subtitle constraints
    func setSubtitleConstraints(){
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        subtitle.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor,constant: 10).isActive = true
        subtitle.topAnchor.constraint(equalTo: title.bottomAnchor,constant: 2).isActive = true
        subtitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
        subtitle.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -12).isActive = true
    }
    
    //MARK: Configuring the lineView constraints
    func setLineViewConstraints(){
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor,constant: 10).isActive = true
        lineView.topAnchor.constraint(equalTo: subtitle.bottomAnchor,constant: 2).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        lineView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -8).isActive = true
    }
    
    //MARK: Configuring the same day shipping constraints
    func setSameDayShippingConstraints(){
        sameDayShipping.translatesAutoresizingMaskIntoConstraints = false
        sameDayShipping.heightAnchor.constraint(equalToConstant: 14).isActive = true
        sameDayShipping.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40).isActive = true
        sameDayShipping.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
}
