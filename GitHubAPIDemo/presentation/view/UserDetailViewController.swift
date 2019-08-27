//
//  UserDetailViewController.swift
//  GitHubAPIDemo
//
//  Created by Bhagyashree Haresh Khatri on 22/08/2019.
//  Copyright © 2019 Bhagyashree Haresh Khatri. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    
    @IBOutlet weak var userAvatarImageview: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userCompanyLabel: UILabel!
    @IBOutlet weak var userReposLabel: UILabel!
    @IBOutlet weak var userFollowersLabel: UILabel!
    @IBOutlet weak var usersFollowingLabel: UILabel!
    var userDetails  : UserDetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    //MARK: Custom Functions
    func config(){
        userNameLabel.text = userDetails?.name ?? "No data available"
        userCompanyLabel.text = userDetails?.company ?? "No data available"
        let publicRepos = userDetails?.public_repos ?? 0
        userReposLabel.text = String(publicRepos)
        let followers = userDetails?.followers ?? 0
        userFollowersLabel.text = String(followers)
        let following = userDetails?.following ?? 0
        usersFollowingLabel.text = String(following)
        if let url = userDetails?.avatar_url {
            userAvatarImageview.kf.setImage(with: URL(string:url))
        }
        else{
            userAvatarImageview.image = UIImage(named: "defaultUserImg")
        }
        self.userAvatarImageview.setRounded()
    }
    
}
