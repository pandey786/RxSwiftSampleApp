//
//  NetworkConnection.swift
//  RxSwiftSampleApp
//
//  Created by Durgesh Pandey on 08/11/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class NetworkConnectionManager {
    
    //Create a shared instance
    static let sharedManager = NetworkConnectionManager()
    
    //write private initializer to prevent from multiple instance creation
    private init() {
        
    }
    
    // MARK: - API Call
    func serviceRequest(urlString: String) throws -> Observable<[String: AnyObject]> {
        
        guard let url = URL.init(string: urlString) else {
            throw exampleError("Could not Create URl from string")
        }
        
        return URLSession.shared.rx.json(url: url).map { jsonObject in

            guard let responseJson = jsonObject as? [String: AnyObject] else {
                throw exampleError("Could not cast json into dictionary")
            }
        
            return responseJson
        }.observeOn(MainScheduler.instance)
    }
    
    /*
     private func parseJSON(_ json: [String: AnyObject]) throws -> [User] {
     guard let results = json["results"] as? [[String: AnyObject]] else {
     throw exampleError("Can't find results")
     }
     
     let userParsingError = exampleError("Can't parse user")
     
     let searchResults: [User] = try results.map { user in
     let name = user["name"] as? [String: String]
     let pictures = user["picture"] as? [String: String]
     
     guard let firstName = name?["first"], let lastName = name?["last"], let imageURL = pictures?["medium"] else {
     throw userParsingError
     }
     
     let returnUser = User(
     firstName: firstName.capitalized,
     lastName: lastName.capitalized,
     imageURL: imageURL
     )
     return returnUser
     }
     
     return searchResults
     }
     */
}
