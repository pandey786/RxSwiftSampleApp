//
//  AppUtils.swift
//  RxSwiftSampleApp
//
//  Created by Durgesh Pandey on 08/11/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

//Create a DisposeBag so subscription will be canceled correctly
let disposeBag = DisposeBag()

func exampleError(_ error: String, location: String = "\(#file):\(#line)") -> NSError {
    return NSError(domain: "ExampleError", code: -1, userInfo: [NSLocalizedDescriptionKey: "\(location): \(error)"])
}

struct WebServiceUrl {
    
    //Base Url
    static let BASE_URL: String = "https://itunes.apple.com/search?media=music&entity=song&term="
}

extension UIViewController {
    
    func setUpNavigationBar(title: String) {
        
        //Set Large Title for Navigation Bar
        self.title = title
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        //Change Fontcolor for Large navigation Title
        let attributes = [NSAttributedStringKey.foregroundColor : UIColor.darkGray]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
    
}
