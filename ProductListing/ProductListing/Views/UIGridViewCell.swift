//
//  UIGridViewCell.swift
//  ProductListing
//
//  Created by Praveen Ramalingam on 17/02/23.
//

import UIKit

class UIGridViewCell: UICollectionViewCell {
    static let identifier = "ImageCollectionViewCell"
    //MARK: all the properties related to the cell
    private var itemImageView = UIImageView()
    private var titleLabel = UILabel()
    private var subtitleLabel = UILabel()
    private var sameDayShippingLabel = UILabel()
    private var lineView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(itemImageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(sameDayShippingLabel)
        
        //Setting the titleLabel, subtitleLabel, image view constraints
        setTitleConstraints()
        setSubtitleConstraints()
        setImageViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Configuring the image corner radius
    public func configureImageView(image: String?){
        itemImageView.layer.cornerRadius = 2
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
    func configureTitle(titleLabel: String){
        self.titleLabel.text = titleLabel
        self.titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        self.titleLabel.textColor = UIColor.black
    }
    
    //MARK: Configuring the subtitleLabel properties
    func configureSubtitle(subtitleLabel: String){
        self.subtitleLabel.text = subtitleLabel
        self.subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        self.subtitleLabel.textColor = UIColor.black
    }
    
    //MARK: Configuring the same day shipping properties
    func configureSameDayShipping(shippingDay: String?){
        self.sameDayShippingLabel.text = shippingDay
        self.sameDayShippingLabel.adjustsFontSizeToFitWidth = true
        self.sameDayShippingLabel.font = sameDayShippingLabel.font.withSize(14)
        self.sameDayShippingLabel.textColor = UIColor.lightGray
    }
    
    //MARK: Configuring the image constraints
    func setImageViewConstraints(){
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        itemImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        itemImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        itemImageView.widthAnchor.constraint(equalTo: itemImageView.heightAnchor).isActive = true
    }
    
    //MARK: Configuring the titleLabel constraints
    func setTitleConstraints(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 5).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: 0).isActive = true
    }
    
    //MARK: Configuring the subtitleLabel constraints
    func setSubtitleConstraints(){
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
