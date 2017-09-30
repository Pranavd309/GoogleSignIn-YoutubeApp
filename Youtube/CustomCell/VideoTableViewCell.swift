//
//  VideoTableViewCell.swift
//  Youtube
//
//  Created by Pranav Shashikant Deshpande on 9/29/17.
//  Copyright © 2017 Pranav Shashikant Deshpande. All rights reserved.
//

import UIKit
import Kingfisher

class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var videoThumbnail: UIImageView?
    @IBOutlet weak var videoTitle: UILabel?
    @IBOutlet weak var channelTitle: UILabel!
    @IBOutlet weak var publishDate: UILabel!
    private var video: Video?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCellData(_ video: Video){
        self.video = video
        let url = URL(string: video.getThumbnailUrl())
        videoThumbnail?.kf.setImage(with: url)
        videoTitle?.text = video.getName()
        publishDate?.text = video.getPublishedDate()
        channelTitle?.text = video.getChannelTitle()
    }
}

