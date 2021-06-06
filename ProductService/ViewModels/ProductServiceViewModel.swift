//
//  ProductServiceViewModel.swift
//  ProductService
//
//  Created by ESHITA on 06/06/21.
//

import Foundation

class ProductServiceViewModel  {
var onResultReceived: ((ProductData) -> Void)?
    
   init() {
        fetchProductService()
    }
    
    private func fetchProductService() {
        ProductService().getProductData() { [weak self] resultData in
            if let result = resultData?.data {
                self?.onResultReceived?(result)
            }
        }
    }
}
