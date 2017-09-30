//
//  SearchResponse.swift
//  Youtube
//
//  Created by Pranav Shashikant Deshpande on 9/29/17.
//  Copyright © 2017 Pranav Shashikant Deshpande. All rights reserved.
//

import Foundation

class SearchResponse {
    
    var videos: [Video]?
    var nextPageToken: String?
    var resultsPerPage: Int?
    var totalResults: Int?
    
    init(_ videos: [Video], _ nextPageToken:String, _ resultsPerPage: Int, _ totalResults: Int) {
        self.videos = videos
        self.nextPageToken = nextPageToken
        self.resultsPerPage = resultsPerPage
        self.totalResults = totalResults
    }
    
    func getVideosList() -> [Video]?{
        return videos
    }
    
    func getNextPageToken() -> String? {
        return nextPageToken
    }
    
    func getResultsPerPage() -> Int? {
        return resultsPerPage
    }
    
    func getTotalResults() -> Int? {
        return totalResults
    }
}

