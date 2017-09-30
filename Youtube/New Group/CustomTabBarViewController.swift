//
//  CustomTabBarViewController.swift
//  Youtube
//
//  Created by Pranav Shashikant Deshpande on 9/29/17.
//  Copyright © 2017 Pranav Shashikant Deshpande. All rights reserved.
//

import UIKit

class CustomTabBarViewController: UITabBarController {
    
    let tabPosition = [0:"Search", 1:"Favorites", 2:"History"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor.red
        self.title = tabPosition[0] ?? "Youtube"
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        title = tabPosition[item.tag] ?? "Youtube"
    }
    
}

