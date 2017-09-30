//
//  DetailedVideoViewController.swift
//  Youtube
//
//  Created by Pranav Shashikant Deshpande on 9/29/17.
//  Copyright © 2017 Pranav Shashikant Deshpande. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
import Toast_Swift

class DetailedVideoViewController: UIViewController {
    
    var video: Video!
    let pVars = ["playsinline":1,"showinfo":0,"rel":1,"controls":1,"origin":"https://www.youtube.com","modestbranding":1] as [String : Any]
    
    @IBOutlet weak var youtubePlayer: YTPlayerView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var channelTitle: UILabel!
    @IBOutlet weak var publishDate: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var downloadProgress: UIProgressView!
    @IBOutlet weak var audioPlayer: YoutubeAudioPlayer!
    @IBOutlet weak var youtubeLoaderView: UIView!
    
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            saveToFavoritesButtonClicked()
        case 2:
            downloadButtonClicked()
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        // super.viewDidLoad()
        youtubePlayer.delegate = self
        // initViews()
    }
    
    private func initViews(){
        youtubePlayer.load(withVideoId: video.getId(), playerVars: pVars)
        audioPlayer.delegate = self
        
        if video.getLocalUrl() != ""{
            audioAvailableUIUpdate(URL(string: video.getLocalUrl()))
        }
        
        favoriteButton.isSelected = video.isSavedAsFavorite()
        videoTitle.text = video.getName()
        channelTitle.text = video.getChannelTitle()
        publishDate.text = video.getPublishedDate()
    }
    
    private func audioAvailableUIUpdate(_ url: URL?) {
        if let url = url {
            downloadButton.isHidden = true
            downloadProgress.isHidden = true
            audioPlayer.isHidden = false
            audioPlayer.loadUrl(url)
        }else {
            self.view.makeToast("Invalid audio link", duration: 3.0, position: .bottom)
        }
    }
    
    private func downloadButtonClicked(){
        downloadButton.isEnabled = false
        AudoioDownloadServices.fetchDownloadLink(video.getId(), { [weak self] (responseUrl) in
            if let weakSelf = self {
                if let url = responseUrl {
                    _ = CoreDataHelper.saveAudioUrl(weakSelf.video.getId(), url.absoluteString)
                    weakSelf.audioAvailableUIUpdate(url)
                }else {
                    weakSelf.view.makeToast("Failed downloading audio", duration: 3.0, position: .bottom)
                    weakSelf.downloadButton.isEnabled = true
                    weakSelf.downloadProgress.progress = 0
                }
                
            }}, { [weak self] (progress) in
                self?.downloadProgress.progress = Float(progress)
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // audioPlayer.stopAudio()
    }
    
    private func saveToFavoritesButtonClicked(){
        if !favoriteButton.isSelected {
            video = CoreDataHelper.saveVideo(video, .Favorites)
            favoriteButton.isSelected = true
        }else{
            _ = CoreDataHelper.removeVideo(video, .Favorites)
            favoriteButton.isSelected = false
        }
    }
}

extension DetailedVideoViewController: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        youtubePlayer.isHidden = false
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        switch state {
        case .playing:
            audioPlayer.stopAudio()
        default:
            break
        }
    }
    
    func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
        //Todo Notify user with any errors.
    }
}

extension DetailedVideoViewController: YoutubeAudioDelegate {
    func audioDidPlay() {
        youtubePlayer.pauseVideo()
    }
}

