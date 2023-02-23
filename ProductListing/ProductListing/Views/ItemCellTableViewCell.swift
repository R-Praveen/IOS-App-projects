//
//  ItemCellTableViewCell.swift
//  ProductListing
//
//  Created by Praveen Ramalingam on 17/02/23.
//

import UIKit

class ItemCellTableViewCell: UITableViewCell {
    static let identifier = "CustomTableViewCell"
    var cell = UIView()
    var leftHalf = UIView()
    var rightHalf = UIView()
    
    var titleRow = UIView()
    var subtitleRow = UIView()
    var dividerRow = UIView()
    
    var itemImage = UIImageView()
    var title = UILabel()
    var subtitle = UILabel()
    var mrp = UILabel()
    var sameDayShipping = UILabel()
    var lineView = UIView()
    
    func addCellContraint(){
        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.heightAnchor.constraint(equalToConstant: 70).isActive = true
        cell.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 34).isActive = true
        cell.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -34).isActive = true
    }
    
    func leftHalfConstraints(){
        leftHalf.translatesAutoresizingMaskIntoConstraints = false
        leftHalf.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
        leftHalf.heightAnchor.constraint(equalToConstant: 70).isActive = true
        leftHalf.widthAnchor.constraint(equalToConstant: 60).isActive = true
        leftHalf.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        leftHalf.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -12).isActive = true
    }
    
    func rightHalfConstraints(){
        rightHalf.translatesAutoresizingMaskIntoConstraints = false
        rightHalf.leadingAnchor.constraint(equalTo: leftHalf.trailingAnchor,constant: 16).isActive = true
        rightHalf.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
        rightHalf.heightAnchor.constraint(equalToConstant: 70).isActive = true
        rightHalf.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        rightHalf.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(cell)
        
        cell.addSubview(leftHalf)
        cell.addSubview(rightHalf)
        
        leftHalf.addSubview(itemImage)
        rightHalf.addSubview(titleRow)
        rightHalf.addSubview(subtitleRow)
        rightHalf.addSubview(lineView)

        titleRow.addSubview(title)
        subtitleRow.addSubview(subtitle)
        subtitleRow.addSubview(mrp)
        subtitleRow.addSubview(sameDayShipping)
        
        configureLineView()

        addCellContraint()
        leftHalfConstraints()
        rightHalfConstraints()
        setImageConstraints()
        setTitleRowConstraints()

        subtitleRowConstraints()
        setTitleConstraints()
        setMRPConstraints()
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
        self.title.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        self.title.textColor = UIColor.black
    }
    
    func configureMRP(){
        mrp.text = "MRP:"
        mrp.textColor = UIColor(named: "mrpColor")
        mrp.font = UIFont.systemFont(ofSize: 14, weight: .light)
    }
    
    //MARK: Configuring the subtitle properties
    func configureSubtitle(subtitle: String){
        self.subtitle.text = subtitle.trimmingCharacters(in: [" "])
        self.subtitle.font = UIFont.systemFont(ofSize: 14, weight: .light)
        self.subtitle.textColor = UIColor.black
    }
    
    //MARK: Configuring the same day shipping properties
    func configureSameDayShipping(shippingDay: String?){
        sameDayShipping.text = shippingDay
        sameDayShipping.font = sameDayShipping.font.withSize(14)
        sameDayShipping.textColor = UIColor.lightGray
    }
    
    //MARK: Configuring the line view
    func configureLineView(){
        lineView.layer.borderWidth = 0.5
        lineView.layer.borderColor = UIColor(named: "dividerColor")?.cgColor
    }
    
    //MARK: Configuring the image constraints
    func setImageConstraints(){
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        itemImage.leadingAnchor.constraint(equalTo: leftHalf.leadingAnchor).isActive = true
        itemImage.heightAnchor.constraint(equalTo: leftHalf.heightAnchor).isActive = true
        itemImage.widthAnchor.constraint(equalTo: leftHalf.widthAnchor).isActive = true
        itemImage.topAnchor.constraint(equalTo: leftHalf.topAnchor).isActive = true
    }
    
   func setTitleRowConstraints(){
       titleRow.translatesAutoresizingMaskIntoConstraints = false
       titleRow.leadingAnchor.constraint(equalTo: rightHalf.leadingAnchor).isActive = true
       titleRow.trailingAnchor.constraint(equalTo: rightHalf.trailingAnchor).isActive = true
       titleRow.topAnchor.constraint(equalTo: rightHalf.topAnchor).isActive = true
       titleRow.heightAnchor.constraint(equalToConstant: 20).isActive = true
   }
    
    func subtitleRowConstraints(){
        subtitleRow.translatesAutoresizingMaskIntoConstraints = false
        subtitleRow.heightAnchor.constraint(equalToConstant: 20).isActive = true
        subtitleRow.topAnchor.constraint(equalTo: titleRow.bottomAnchor,constant: 4).isActive = true
        subtitleRow.leadingAnchor.constraint(equalTo: rightHalf.leadingAnchor).isActive = true
        subtitleRow.trailingAnchor.constraint(equalTo: rightHalf.trailingAnchor).isActive = true
    }
    
    //MARK: Configuring the title constraints
    func setTitleConstraints(){
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leadingAnchor.constraint(equalTo: titleRow.leadingAnchor).isActive = true
        title.topAnchor.constraint(equalTo: titleRow.topAnchor).isActive = true
    }
    
    //MARK: Configuring the MRP constraints
    func setMRPConstraints(){
        mrp.translatesAutoresizingMaskIntoConstraints = false
        mrp.leadingAnchor.constraint(equalTo: subtitleRow.leadingAnchor).isActive = true
        mrp.topAnchor.constraint(equalTo: subtitleRow.topAnchor,constant: 2).isActive = true
    }
    
    //MARK: Configuring the subtitle constraints
    func setSubtitleConstraints(){
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        subtitle.leadingAnchor.constraint(equalTo: mrp.trailingAnchor,constant: 4).isActive = true
        subtitle.topAnchor.constraint(equalTo: subtitleRow.topAnchor,constant: 2).isActive = true
    }
    
    //MARK: Configuring the lineView constraints
    func setLineViewConstraints(){
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.leadingAnchor.constraint(equalTo: rightHalf.leadingAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineView.trailingAnchor.constraint(equalTo: rightHalf.trailingAnchor).isActive = true
        lineView.bottomAnchor.constraint(equalTo: rightHalf.bottomAnchor,constant: -8).isActive = true
    }
    
    //MARK: Configuring the same day shipping constraints
    func setSameDayShippingConstraints(){
        sameDayShipping.translatesAutoresizingMaskIntoConstraints = false
        sameDayShipping.topAnchor.constraint(equalTo: subtitleRow.topAnchor,constant: 2).isActive = true
        sameDayShipping.trailingAnchor.constraint(equalTo: subtitleRow.trailingAnchor).isActive = true
    }
    
}
