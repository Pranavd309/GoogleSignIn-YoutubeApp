//
//  YoutubeAudioPlayer.swift
//  Youtube
//
//  Created by Pranav Shashikant Deshpande on 9/29/17.
//  Copyright © 2017 Pranav Shashikant Deshpande. All rights reserved.
//

import UIKit
import AVFoundation


@objc protocol YoutubeAudioDelegate: NSObjectProtocol {
    @objc optional func audioDidStop()
    @objc optional func audioDidPlay()
    @objc optional func audioEnded()
}

@IBDesignable
class YoutubeAudioPlayer: UIView {
    
    var contentView : UIView!
    var player: AVAudioPlayer?
    var progressUpdater: CADisplayLink?
    var audioDuration: TimeInterval?
    var delegate: YoutubeAudioDelegate?
    
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var audioProgress: UIProgressView!
    
    @IBAction func play(_ sender: UIButton) {
        if let audioPlayer = player {
            if audioPlayer.isPlaying {
                stopAudio()
            }else {
                playAudio()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func loadUrl(_ url: URL) {
        player = try? AVAudioPlayer(contentsOf: url)
        player?.delegate = self
        player?.prepareToPlay()
        audioDuration = player?.duration
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            print("AVAudioSession Category Playback OK")
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession is Active")
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    @objc func trackAudio() {
        let progress = Float((player?.currentTime ?? 0.0) / (audioDuration ?? 0.0))
        print("Progress: \(progress)")
        audioProgress.progress = progress
    }
    
    func playAudio() {
        delegate?.audioDidPlay?()
        playPauseButton.isSelected = true
        progressUpdater = CADisplayLink(target:self, selector: #selector(YoutubeAudioPlayer.trackAudio))
        progressUpdater?.preferredFramesPerSecond = 1
        progressUpdater?.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
        player?.play()
    }
    
    func stopAudio() {
        delegate?.audioDidStop?()
        playPauseButton.isSelected = false
        progressUpdater?.invalidate()
        player?.pause()
    }
    
    
    private func xibSetup() {
        contentView = loadViewFromNib()
        
        contentView.frame = bounds
        
        contentView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        
        addSubview(contentView)
    }
    
    private func loadViewFromNib() -> UIView! {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
}

extension YoutubeAudioPlayer: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        delegate?.audioEnded?()
        audioProgress.progress = 0
        progressUpdater?.invalidate()
        playPauseButton.isSelected = false
    }
}

