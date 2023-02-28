//
//  File.swift
//  ProductListing
//
//  Created by Praveen Ramalingam on 24/02/23.
//

import Foundation
import UIKit

//Controller responsible for the empty page.
class EmptyPageController: UIViewController{
    
    var label = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.backgroundColor = .white
        label.text = "Coming Soon..."
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        setConstraints()
    }
    
    func setConstraints(){
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
}
