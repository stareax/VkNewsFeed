//
//  FeedViewController.swift
//  VkNewsFeed
//
//  Created by Дарья Выскворкина on 19.01.2021.
//

import UIKit

class FeedViewController: UIViewController {
    private let networkService: Networking = NetworkService()
    override func viewDidLoad() {
        super.viewDidLoad()
        let params = ["filters":"post,photo"]
        view.backgroundColor = .systemBlue
        networkService.request(path: API.newsFeed, params: params) { (data, error) in
            
        }
    }
}
