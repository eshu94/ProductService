//
//  ProductServiceModel.swift
//  ProductService
//
//  Created by ESHITA on 06/06/21.
//

import Foundation
import UIKit

class ProductService {
    
    // MARK:- Function to get Product Data
    func getProductData(completion: @escaping ((ResultData?) -> Void)) {
        print("getProductData: Start")
        guard let url = URL(string: "http://customer_server.maharah.neumtech.net/api/Vendors/testAPI") else {
               fatalError("URL is not correct")
        }
        
        var request = URLRequest(url: url)
          request.addValue("CIGfMA0GCSqGSIb3DQEBAQdqDup1pgSc0tQUMQUAA4GNADCBiQKBgQD3apAg6H2i", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
              guard let data = data, error == nil else {
                  DispatchQueue.main.async {
                      completion(nil)
                  }
                  return
              }
            print(data.responseJSONString as Any)
            
              let productList = try? JSONDecoder().decode(ResultData.self, from: data)
              if let product = productList {
                  completion(product)
              }
          }.resume()
        
        print("getProductData: End")
    }
}


// MARK:- API Response Model

struct ResultData: Decodable {
    var status: Bool?
    var message: String?
    var data: ProductData?
    
}

struct ProductData: Decodable {
    var category:String? //category_name
    var description:String?
    var imgPath: String? // image_url
    var services: [ServiceItem]?
    
    private enum CodingKeys: String, CodingKey {
        case category = "category_name"
        case description
        case imgPath = "image_url"
        case services
    }
}

struct ServiceItem: Decodable {
    
    var serviceName: String //service_name
    var rate: Int
    var description: String
    var imgPath: String // image_url
    
    private enum CodingKeys: String, CodingKey {
        case serviceName = "service_name"
        case description
        case imgPath = "image_url"
        case rate
    }
    
}

extension Data {
    var responseJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let responseJSONString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        return responseJSONString
    }
}
