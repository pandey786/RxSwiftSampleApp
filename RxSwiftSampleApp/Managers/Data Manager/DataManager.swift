//
//  DataManager.swift
//  RxSwiftSampleApp
//
//  Created by Durgesh Pandey on 08/11/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DataManager {
    
    func getDataBasedOnSearchtext(searchtext: String) throws -> Observable<[SongDataModel]> {
       
        do {
           return try NetworkConnectionManager.sharedManager.serviceRequest(urlString: WebServiceUrl.BASE_URL.appending(searchtext)).map({ value in
                return try self.parseJSON(value)
            })
        } catch (let error) {
            throw error
        }
    }
    
    private func parseJSON(_ json: [String: AnyObject]) throws -> [SongDataModel] {
        
        guard let results = json["results"] as? [[String: AnyObject]] else {
            throw exampleError("Can't find results")
        }
        
        let songParsingError = exampleError("Can't parse Song")
        
        let searchResults: [SongDataModel] = try results.map { songDict in
            
            guard let artistId = songDict["artistId"] as? Int, let artistName = songDict["artistName"] as? String, let artworkUrl100 = songDict["artworkUrl100"] as? String, let primaryGenreName = songDict["primaryGenreName"] as? String, let releaseDate = songDict["releaseDate"] as? String, let trackName = songDict["trackName"] as? String else {
                throw songParsingError
            }
           
            let returnSong = SongDataModel.init(artistId: artistId, artistName: artistName, artworkUrl100: artworkUrl100, primaryGenreName: primaryGenreName, releaseDate: releaseDate, trackName: trackName)
            
            return returnSong
        }
        
        return searchResults
    }
}
