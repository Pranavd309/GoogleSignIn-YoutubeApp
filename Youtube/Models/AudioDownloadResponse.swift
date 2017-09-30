//
//  AudioDownloadResponse.swift
//  Youtube
//
//  Created by Pranav Shashikant Deshpande on 9/29/17.
//  Copyright © 2017 Pranav Shashikant Deshpande. All rights reserved.
//

import Foundation

class AudioDownloadResponse {
    
    private var title: String?
    private var length: String?
    private var link: String?
    
    
    init(_ title: String, _ length: String, _ link: String) {
        self.title = title
        self.length = length
        self.link = link
    }
    
    func getTitle() -> String {
        return title ?? ""
    }
    
    func getLength() -> String {
        return length ?? "0"
    }
    
    func getLink() -> String {
        return link ?? ""
    }
}

