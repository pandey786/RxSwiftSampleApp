//
//  ViewController.swift
//  RxSwiftSampleApp
//
//  Created by Durgesh Pandey on 08/11/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up navigation Bar
        setUpNavigationBar(title: "Home")
        
        //Create an Observable sequence
        let sampleObservableSequence1 = Observable.of("Durgesh Pandey")
        let sampleObservableSequence2 = Observable.from([1, 2, 3, 4, 5])
        let sampleObservableSequence3 = Observable.just("Durgesh Pandey")
        let sampleObservableSequence4 = Observable.from([1: "First", 2: "Second"])
        
        print(sampleObservableSequence2)
        print(sampleObservableSequence3)
        print(sampleObservableSequence4)
        
        //Create Subscriptions
        let subscription1 = sampleObservableSequence1.subscribe { (event) in
            
            switch event {
            case .next(let value):
                print(value)
            case .error(let error):
                print(error)
            case .completed:
                print("Completed")
            }
        }
        
        //dispose the subscription
        subscription1.disposed(by: disposeBag)
        
        //Subjects
        checkAndtestSubjectsInRxSwift()
        
        //Transformations in Swift
        transformationsInRxSwift()
        
    }
    
    func transformationsInRxSwift() {
        
        //Map
        print("Map")
        let observableSequence = Observable.from([1, 2, 3, 4, 5, 6])
    
        observableSequence.map { value in
            return value * 15
            }.subscribe(onNext: {
                
                print($0)
            }).disposed(by: disposeBag)
        
    }
    
    func checkAndtestSubjectsInRxSwift() {
        
        /*
         There are 4 Subjects in RxSwift
         1. Public Subject : 0
         2. Behaviour : 1
         3. variable : 1
         4. Replay : N
         */
        
        let samplePublishSubject = PublishSubject<String>()
        
        let samplePublishEventSubscription = samplePublishSubject.subscribe(onNext: { (value) in
            print(value)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
        }) {
        }
        samplePublishEventSubscription.disposed(by: disposeBag)
        
        samplePublishSubject.onNext("Durgesh")
        samplePublishSubject.onNext("Hello")

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

