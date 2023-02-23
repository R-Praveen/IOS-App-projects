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
    private var itemImage = UIImageView()
    private var title = UILabel()
    private var subtitle = UILabel()
    private var sameDayShipping = UILabel()
    private var lineView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(itemImage)
        addSubview(title)
        addSubview(subtitle)
        addSubview(sameDayShipping)
        
        //Setting the title, subtitle, image view constraints
        setTitleConstraints()
        setSubtitleConstraints()
        setImageViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Configuring the image corner radius
    public func configureImageView(image: String?){
        itemImage.layer.cornerRadius = 2
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
        self.title.font = UIFont.systemFont(ofSize: 14, weight: .light)
        self.title.textColor = UIColor.black
    }
    
    //MARK: Configuring the subtitle properties
    func configureSubtitle(subtitle: String){
        self.subtitle.text = subtitle
        self.subtitle.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        self.subtitle.textColor = UIColor.black
    }
    
    //MARK: Configuring the same day shipping properties
    func configureSameDayShipping(shippingDay: String?){
        self.sameDayShipping.text = shippingDay
        self.sameDayShipping.adjustsFontSizeToFitWidth = true
        self.sameDayShipping.font = sameDayShipping.font.withSize(14)
        self.sameDayShipping.textColor = UIColor.lightGray
    }
    
    //MARK: Configuring the image constraints
    func setImageViewConstraints(){
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        itemImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        itemImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        itemImage.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        itemImage.widthAnchor.constraint(equalTo: itemImage.heightAnchor).isActive = true
    }
    
    //MARK: Configuring the title constraints
    func setTitleConstraints(){
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        title.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 5).isActive = true
        title.bottomAnchor.constraint(equalTo: subtitle.topAnchor, constant: 0).isActive = true
    }
    
    //MARK: Configuring the subtitle constraints
    func setSubtitleConstraints(){
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        subtitle.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 6).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
