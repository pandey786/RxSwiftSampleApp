//
//  ITunesSearchViewController.swift
//  RxSwiftSampleApp
//
//  Created by Durgesh Pandey on 08/11/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class ITunesSearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //Search Controller
    let searchController = UISearchController.init(searchResultsController: nil)
    
    //Search Results
    var searchResults: Variable<[SongDataModel]> = Variable([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up navigation Bar
        setUpNavigationBar(title: "ITunes Search")
        
        //Sert Dynamic height of table cell
        tableView.estimatedRowHeight = 50
        
        //set up Search Controller
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
        
        //Set Up Search Result Observers
        setUpSearchResultsObservers()
        
        //Set up Search bar Observers
        setUpSearchBarObservers()
        
        //Set up table Cell Configuration
        setUpTableCellConfiguration()
    }
    
    func setUpSearchBarObservers() {
        
        searchController.searchBar.rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .subscribe(onNext: {
                [unowned self] value in
                
                //Assign this to variable
                do {
                    try DataManager().getDataBasedOnSearchtext(searchtext: value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!).bind(to: self.searchResults).disposed(by: disposeBag)
                } catch (let error){
                    print(error)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func setUpSearchResultsObservers() {
        
    }
}

extension ITunesSearchViewController: UITableViewDelegate {
    
    func setUpTableCellConfiguration() {
        
        searchResults.asObservable().bind(to: tableView.rx.items(cellIdentifier: "ITunesSearchTableViewCell")) {(index, song: SongDataModel, cell: ITunesSearchTableViewCell) in
            
            //Set Up Cell
            cell.lblTitle.text = song.trackName
            cell.lblSubTitle.text = song.artistName
            let imageUrl = URL(string: song.artworkUrl100)
            cell.imgView.kf.setImage(with: imageUrl)
            
            //Set Round Image VIew
            cell.imgView.layer.cornerRadius = 30.0
            cell.imgView.layer.masksToBounds = true
            
            }.disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
