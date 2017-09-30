//
//  ViewController.swift
//  Youtube
//
//  Created by Pranav Shashikant Deshpande  on 9/29/17.
//  Copyright © 2017 Pranav Shashikant Deshpande . All rights reserved.
//

import UIKit

class ViewController: UIViewController ,GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

