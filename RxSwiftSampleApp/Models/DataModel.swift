//
//  DataModel.swift
//  RxSwiftSampleApp
//
//  Created by Durgesh Pandey on 08/11/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import Foundation

struct SongDataModel {
    
    var artistId: Int
    var artistName: String
    var artworkUrl100: String
    var primaryGenreName: String
    var releaseDate: String
    var trackName: String
    
    init(artistId: Int, artistName: String, artworkUrl100: String, primaryGenreName: String, releaseDate: String, trackName: String) {
        
        self.artistId = artistId
        self.artistName = artistName
        self.artworkUrl100 = artworkUrl100
        self.primaryGenreName = primaryGenreName
        self.releaseDate = releaseDate
        self.trackName = trackName
    }
}
