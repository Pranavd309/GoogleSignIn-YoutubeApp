//
//  YoutubeServices.swift
//  Youtube
//
//  Created by Pranav Shashikant Deshpande on 9/29/17.
//  Copyright © 2017 Pranav Shashikant Deshpande. All rights reserved.
//

import Foundation
import Alamofire

class YoutubeServices {
    
    private static let apiKey = "AIzaSyA1VTC9rqm7B9tpL7I8wWgl2_pzK51lWsk"
    private static let baseUr = "https://developers.google.com/youtube/v3/quickstart/ios"
    private static var part = "id,snippet"
    private static var maxResults = 50
    private static var order = "viewCount"
    private static let baseUrl = "https://www.googleapis.com/youtube/v3/search"
    
    static func searchVideos(_ searchQuery: String,_ closure:@escaping (_ vid:[Video]) -> Void){
        let params:Parameters = ["part":part,"maxResults":maxResults,"key":apiKey,"q":searchQuery,"type":"video","order":order]
        Alamofire.request(baseUrl, parameters: params)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                switch response.result{
                case .success:
                    if let json = response.result.value as? [String:Any] {
                        let searchResponse = JsonFormatter.formatYouTubeJsonSearchResponse(json)
                        closure(searchResponse.getVideosList() ?? [])
                    }else {
                        closure([])
                    }
                case .failure(let error):
                    //The Application does not handling errors yet.
                    print(error)
                }
        }
    }
}

