//
//  ProductServiceViewController.swift
//  ProductService
//
//  Created by ESHITA on 06/06/21.
//

import Foundation
import UIKit

class ProductServiceViewController: UIViewController {
    
    @IBOutlet weak var topImageView:UIImageView!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryTitleLbl:UILabel!
    @IBOutlet weak var categoryDescLbl:UILabel!
    @IBOutlet weak var categoryIV:UIImageView!
    @IBOutlet weak var productServiceTableView: UITableView!
    @IBOutlet weak var tableTitleView: UIView!
    private var productServiceVM = ProductServiceViewModel()
    private var productServiceList:[ServiceItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productServiceVM.onResultReceived = { [weak self] resultData in
            DispatchQueue.main.async {
                self?.categoryTitleLbl.text = resultData.category
                self?.categoryDescLbl.text = resultData.description
                self?.productServiceList = resultData.services ?? []
                self?.productServiceTableView.reloadData()
            }
            
        }
        self.productServiceTableView.delegate = self
        self.productServiceTableView.dataSource = self
    }
    
}
extension ProductServiceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productServiceList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.productServiceTableView.dequeueReusableCell(withIdentifier: "serviceIdentifier") as! ServiceCustomeTableViewCell
        cell.populateProductData(serviceData: self.productServiceList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 98
   }

}

