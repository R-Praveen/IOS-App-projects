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
    var imageSectionView = UIView()
    var contentSectionView = UIView()
    
    var titleLabelSectionView = UIView()
    var subtitleLabelLabelSectionView = UIView()
    var dividerSectionView = UIView()
    
    var itemImageView = UIImageView()
    var titleLabel = UILabel()
    var subtitleLabel = UILabel()
    var mrpLabel = UILabel()
    var sameDayShippingLabel = UILabel()
    var lineView = UIView()
    
    func addCellContraint(){
        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.heightAnchor.constraint(equalToConstant: 70).isActive = true
        cell.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 34).isActive = true
        cell.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -34).isActive = true
    }
    
    func imageSectionViewConstraints(){
        imageSectionView.translatesAutoresizingMaskIntoConstraints = false
        imageSectionView.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
        imageSectionView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        imageSectionView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageSectionView.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        imageSectionView.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -12).isActive = true
    }
    
    func contentSectionViewConstraints(){
        contentSectionView.translatesAutoresizingMaskIntoConstraints = false
        contentSectionView.leadingAnchor.constraint(equalTo: imageSectionView.trailingAnchor,constant: 16).isActive = true
        contentSectionView.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
        contentSectionView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        contentSectionView.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        contentSectionView.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(cell)
        
        cell.addSubview(imageSectionView)
        cell.addSubview(contentSectionView)
        
        imageSectionView.addSubview(itemImageView)
        contentSectionView.addSubview(titleLabelSectionView)
        contentSectionView.addSubview(subtitleLabelLabelSectionView)
        contentSectionView.addSubview(lineView)

        titleLabelSectionView.addSubview(titleLabel)
        subtitleLabelLabelSectionView.addSubview(subtitleLabel)
        subtitleLabelLabelSectionView.addSubview(mrpLabel)
        subtitleLabelLabelSectionView.addSubview(sameDayShippingLabel)
        
        configureLineView()

        addCellContraint()
        imageSectionViewConstraints()
        contentSectionViewConstraints()
        setImageConstraints()
        settitleLabelSectionViewConstraints()

        subtitleLabelLabelSectionViewConstraints()
        settitleLabelConstraints()
        setmrpLabelConstraints()
        setsubtitleLabelLabelConstraints()
        setsameDayShippingLabelConstraints()
        setLineViewConstraints()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Configuring the image corner radius
    public func configureImageView(image: String?){
        itemImageView.layer.cornerRadius = 10
        downloadImage(from: URL(string:image!)!)
    }
    
    //MARK: Download the image to be shown in the view
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.itemImageView.image = UIImage(data: data)
            }
        }
    }
    
    //MARK: getting the data of the image
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    //MARK: Configuring the titleLabel properties
    func configuretitleLabel(titleLabel: String){
        self.titleLabel.text = titleLabel
        self.titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        self.titleLabel.textColor = UIColor.black
    }
    
    func configuremrpLabel(){
        mrpLabel.text = "MRP:"
        mrpLabel.textColor = UIColor(named: "mrpLabelColor")
        mrpLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
    }
    
    //MARK: Configuring the subtitleLabel properties
    func configuresubtitleLabel(subtitleLabel: String){
        self.subtitleLabel.text = subtitleLabel.trimmingCharacters(in: [" "])
        self.subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        self.subtitleLabel.textColor = UIColor.black
    }
    
    //MARK: Configuring the same day shipping properties
    func configuresameDayShippingLabel(shippingDay: String?){
        sameDayShippingLabel.text = shippingDay
        sameDayShippingLabel.font = sameDayShippingLabel.font.withSize(14)
        sameDayShippingLabel.textColor = UIColor.lightGray
    }
    
    //MARK: Configuring the line view
    func configureLineView(){
        lineView.layer.borderWidth = 0.5
        lineView.layer.borderColor = UIColor(named: "dividerColor")?.cgColor
    }
    
    //MARK: Configuring the image constraints
    func setImageConstraints(){
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.leadingAnchor.constraint(equalTo: imageSectionView.leadingAnchor).isActive = true
        itemImageView.heightAnchor.constraint(equalTo: imageSectionView.heightAnchor).isActive = true
        itemImageView.widthAnchor.constraint(equalTo: imageSectionView.widthAnchor).isActive = true
        itemImageView.topAnchor.constraint(equalTo: imageSectionView.topAnchor).isActive = true
    }
    
   func settitleLabelSectionViewConstraints(){
       titleLabelSectionView.translatesAutoresizingMaskIntoConstraints = false
       titleLabelSectionView.leadingAnchor.constraint(equalTo: contentSectionView.leadingAnchor).isActive = true
       titleLabelSectionView.trailingAnchor.constraint(equalTo: contentSectionView.trailingAnchor).isActive = true
       titleLabelSectionView.topAnchor.constraint(equalTo: contentSectionView.topAnchor).isActive = true
       titleLabelSectionView.heightAnchor.constraint(equalToConstant: 20).isActive = true
   }
    
    func subtitleLabelLabelSectionViewConstraints(){
        subtitleLabelLabelSectionView.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabelLabelSectionView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        subtitleLabelLabelSectionView.topAnchor.constraint(equalTo: titleLabelSectionView.bottomAnchor,constant: 4).isActive = true
        subtitleLabelLabelSectionView.leadingAnchor.constraint(equalTo: contentSectionView.leadingAnchor).isActive = true
        subtitleLabelLabelSectionView.trailingAnchor.constraint(equalTo: contentSectionView.trailingAnchor).isActive = true
    }
    
    //MARK: Configuring the titleLabel constraints
    func settitleLabelConstraints(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: titleLabelSectionView.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: titleLabelSectionView.topAnchor).isActive = true
    }
    
    //MARK: Configuring the mrpLabel constraints
    func setmrpLabelConstraints(){
        mrpLabel.translatesAutoresizingMaskIntoConstraints = false
        mrpLabel.leadingAnchor.constraint(equalTo: subtitleLabelLabelSectionView.leadingAnchor).isActive = true
        mrpLabel.topAnchor.constraint(equalTo: subtitleLabelLabelSectionView.topAnchor,constant: 2).isActive = true
    }
    
    //MARK: Configuring the subtitleLabel constraints
    func setsubtitleLabelLabelConstraints(){
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.leadingAnchor.constraint(equalTo: mrpLabel.trailingAnchor,constant: 4).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: subtitleLabelLabelSectionView.topAnchor,constant: 2).isActive = true
    }
    
    //MARK: Configuring the lineView constraints
    func setLineViewConstraints(){
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.leadingAnchor.constraint(equalTo: contentSectionView.leadingAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineView.trailingAnchor.constraint(equalTo: contentSectionView.trailingAnchor).isActive = true
        lineView.bottomAnchor.constraint(equalTo: contentSectionView.bottomAnchor,constant: -8).isActive = true
    }
    
    //MARK: Configuring the same day shipping constraints
    func setsameDayShippingLabelConstraints(){
        sameDayShippingLabel.translatesAutoresizingMaskIntoConstraints = false
        sameDayShippingLabel.topAnchor.constraint(equalTo: subtitleLabelLabelSectionView.topAnchor,constant: 2).isActive = true
        sameDayShippingLabel.trailingAnchor.constraint(equalTo: subtitleLabelLabelSectionView.trailingAnchor).isActive = true
    }
    
}
