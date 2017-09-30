//
//  BaseViewController.swift
//  Youtube
//
//  Created by Pranav Shashikant Deshpande on 9/29/17.
//  Copyright © 2017 Pranav Shashikant Deshpande. All rights reserved.
//


import UIKit

class BaseViewController: UIViewController{
    

    
    var videosListTableViewController: VideosTableViewController?
    
    var videosList: [Video] = [] {
        didSet{
            videosListTableViewController?.setVideosList(videosList)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "VideosEmbededList"{
            videosListTableViewController = segue.destination as? VideosTableViewController
            videosListTableViewController?.delegate = self as? YoutubeVideosTableViewDelegete
        }
    }
    func setYoutubeVideoDelegate(_ delegate: YoutubeVideosTableViewDelegete) {
        videosListTableViewController?.delegate = delegate
    }
}


