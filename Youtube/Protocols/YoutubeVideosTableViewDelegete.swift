//
//  YoutubeVideosTableViewDelegete.swift
//  Youtube
//
//  Created by Pranav Shashikant Deshpande on 9/29/17.
//  Copyright © 2017 Pranav Shashikant Deshpande. All rights reserved.
//

import Foundation

protocol YoutubeVideosTableViewDelegete {
    
    func removeVideoFromList(_ video: Video, _ isLastItem: Bool)
}

