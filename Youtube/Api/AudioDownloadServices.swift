//
//  AudioDownloadServices.swift
//  Youtube
//
//  Created by Pranav Shashikant Deshpande on 9/29/17.
//  Copyright © 2017 Pranav Shashikant Deshpande. All rights reserved.
//

import Foundation
import Alamofire


class AudoioDownloadServices {
    
    private static let format = "JSON"
    private static let videoUrl = "https://www.youtube.com/watch?v="
    private static let baseUrl = "https://www.youtubeinmp3.com/fetch?"
    
    
    static func fetchDownloadLink(_ videoId: String,_ closure:@escaping ( _ audioLink: URL?) -> Void,_ progressClosure:@escaping ( _ progress: Double) -> Void) {
        let params: Parameters = ["format":format, "video":videoUrl+videoId]
        print("init Request")
        Alamofire.request(baseUrl,parameters: params)
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                switch response.result{
                case .success:
                    if let json = response.result.value as? [String:Any] {
                        downloadAudio(JsonFormatter.formatYoutubeDownloadLinkResponse(json).getLink(),closure,progressClosure)
                    }
                    break
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    private static func downloadAudio(_ link: String,_ closure:@escaping ( _ audio: URL?) -> Void, _ progressClosure:@escaping ( _ progress: Double) -> Void)  {
        let destination = DownloadRequest.suggestedDownloadDestination()
        
        Alamofire.download(link,to: destination).response { (response) in
            let urlString = response.destinationURL?.absoluteString ?? ""
            if urlString.contains(".mp3") {
                closure(response.destinationURL)
            }else{
                closure(nil)
            }
            
            }.downloadProgress { (progress) in
                progressClosure(progress.fractionCompleted)
        }
    }
}


