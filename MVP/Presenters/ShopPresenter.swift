//
//  ShopPresenter.swift
//  MVP
//
//  Created by MAC on 01/03/2024.
//

import Foundation

protocol ShopPresenterDelegate: AnyObject {
    func shopDataFetchedSuccessfully(_ shops: [Shop])
    func shopDataFetchingFailed(with error: Error)
}

class ShopPresenter {
    weak var delegate: ShopPresenterDelegate?
    
    func fetchShopData() {
        print("Fetching shop data...")
        
        // Define the API endpoint URL
        guard let url = URL(string: "http://10.100.11.101:5000/retrieveAllShop") else {
            print("Invalid API URL")
            return
        }
        
        // Create a URL session configuration
        let configuration = URLSessionConfiguration.default
        
        // Add custom headers
        configuration.httpAdditionalHeaders = ["secret": "THAW_DE_ZIN", "User-Agent": "Hsu Myat Wai"]
        
        // Create a URL session with the configuration
        let session = URLSession(configuration: configuration)
        
        // Create a data task with the URL session for making a GET request
        let dataTask = session.dataTask(with: url) { data, response, error in
            // Check if there's an error
            if let error = error {
                print("Error fetching shop data: \(error)")
                // Notify delegate of failure with error
                self.delegate?.shopDataFetchingFailed(with: error)
                return
            }
            
            // Check if response data is available
            guard let data = data else {
                print("No data received")
                // Notify delegate of failure with unknown error
                let unknownError = NSError(domain: "ShopPresenter", code: -1, userInfo: nil)
                self.delegate?.shopDataFetchingFailed(with: unknownError)
                return
            }
            
            // Check if response is valid JSON
            do {
                let responseObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] ?? [:]
                print("Received response: \(responseObject)")
                
                // Parse JSON response
                if let shopsJSON = responseObject["shops"] as? [[String: Any]] {
                    var shops: [Shop] = []
                    for shopDict in shopsJSON {
                        let shop = Shop(
                            address: shopDict["address"] as? String ?? "",
                            cluster: shopDict["cluster"] as? String ?? "",
                            shopDescription: shopDict["description"] as? String ?? "",
//                            expireOn: self.dateFromString(shopDict["expireOn"] as? String ?? ""),
                            expireOn: shopDict["expireOn"] as? String ?? "",
                            foodCategory: shopDict["foodCategory"] as? String ?? "",
                            shopID: shopDict["id"] as? String ?? "",
                            img1: shopDict["img1"] as? String ?? "",
                            img2: shopDict["img2"] as? String ?? "",
                            img3: shopDict["img3"] as? String ?? "",
                            isHalalCertified: shopDict["isHalalCertified"] as? Bool ?? false,
                            latitude: shopDict["latitude"] as? String ?? "",
                            longitude: shopDict["longitude"] as? String ?? "",
                            name: shopDict["name"] as? String ?? "",
                            phone: shopDict["phone"] as? String ?? "",
                            preserved1: shopDict["preserved1"] as? String ?? "",
                            preserved2: shopDict["preserved2"] as? String ?? "",
                            remark: shopDict["remark"] as? String ?? "",
                            shopType: shopDict["shopType"] as? String ?? "",
                            socialMediaLink: shopDict["socialMediaLink"] as? String ?? ""
                        )
                        shops.append(shop)

                    }
                    // Notify delegate of successful data fetch
                    self.delegate?.shopDataFetchedSuccessfully(shops)
                } else {
                    print("No shops found in response")
                    // Notify delegate of failure with unknown error
                    let unknownError = NSError(domain: "ShopPresenter", code: -1, userInfo: nil)
                    self.delegate?.shopDataFetchingFailed(with: unknownError)
                }
            } catch {
                print("Error parsing JSON: \(error)")
                // Notify delegate of failure with error
                self.delegate?.shopDataFetchingFailed(with: error)
            }
        }
        
        // Resume the data task to start the request
        dataTask.resume()
    }
}

