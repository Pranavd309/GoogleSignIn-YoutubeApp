//
//  YoutubeSearchViewController.swift
//  Youtube
//
//  Created by Pranav Shashikant Deshpande on 9/29/17.
//  Copyright © 2017 Pranav Shashikant Deshpande. All rights reserved.
//

import UIKit

class YoutubeSearchViewController: BaseViewController{
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableViewContainer: UIView!
    @IBOutlet weak var holderLabel: UILabel!
    
    
    @IBAction func buttonClick(_ sender: UIButton) {
        if let title = sender.currentTitle {
            switch title {
            case "Search":
                if let searchText = searchTextField.text , searchText != "" {
                    self.view.endEditing(true)
                    searchYoutube(searchText)
                }
            default:
                break
            }
        }
    }
    
    
    private func searchYoutube(_ searchQuery: String) {
        holderLabel.isHidden = true
        indicatorView.startAnimating()
        tableViewContainer.isHidden = true
        YoutubeServices.searchVideos(searchQuery) {[weak self] (videosList) in
            if let weakSelf = self {
                weakSelf.videosList = videosList
                weakSelf.indicatorView.stopAnimating()
                weakSelf.tableViewContainer.isHidden = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }
    
}

extension YoutubeSearchViewController: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

