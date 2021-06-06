//
//  ServiceCustomeTableViewCell.swift
//  ProductService
//
//  Created by ESHITA on 06/06/21.
//

import Foundation
import UIKit

class ServiceCustomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var serviceImageView:UIImageView!
    @IBOutlet weak var serviceTitleLbl:UILabel!
    @IBOutlet weak var serviceRateLbl:UILabel!
    @IBOutlet weak var serviceDescLbl:UILabel!
    @IBOutlet weak var serviceAddBtn: UIButton!
    @IBOutlet weak var serviceCellSeperator:UIView!
    
    
    func populateProductData(serviceData: ServiceItem){
        self.serviceTitleLbl.text = serviceData.serviceName
        self.serviceDescLbl.text = serviceData.description
        self.serviceRateLbl.text = String(serviceData.rate)
        guard let imgUrl = URL(string: serviceData.imgPath) else { return }
        downloadImage(from: imgUrl, to: self.serviceImageView)
        self.serviceAddBtn.layer.cornerRadius = 12
    }
    
    @IBAction func addedBtnPressed(_ sender: UIButton){
        
        if sender.isSelected == true {
            sender.backgroundColor = UIColor.init(named: "Button")
            sender.setTitleColor(UIColor.black, for: .normal)
            sender.setTitle("Add", for: .normal)
            sender.isSelected = false
          } else {
            sender.backgroundColor = UIColor.init(named: "ButtonSelected")
            sender.setTitleColor(UIColor.white, for: .normal)
            sender.setTitle("Added", for: .normal)
            sender.isSelected = true
          }
        
    }
    
    // MARK:- Function to get Image
    fileprivate func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    fileprivate func downloadImage(from url: URL, to uiImageView: UIImageView) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                uiImageView.image = UIImage(data: data)
            }
        }
    }
}
