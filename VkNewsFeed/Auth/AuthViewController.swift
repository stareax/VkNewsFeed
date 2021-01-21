//
//  ViewController.swift
//  VkNewsFeed
//
//  Created by Дарья Выскворкина on 18.01.2021.
//

import UIKit
import VK_ios_sdk

class AuthViewController: UIViewController {
    var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authService = SceneDelegate.shared().authService 
    }
    @IBAction func signInTouch(_ sender: UIButton) {
        authService.wakeUpSession()
    }
    
}

