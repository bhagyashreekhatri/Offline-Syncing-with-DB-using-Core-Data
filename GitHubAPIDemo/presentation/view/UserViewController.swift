//
//  UserViewController.swift
//  GitHubAPIDemo
//
//  Created by Bhagyashree Haresh Khatri on 22/08/2019.
//  Copyright © 2019 Bhagyashree Haresh Khatri. All rights reserved.
//

import UIKit
import Kingfisher

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var loginNameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
   
}

class UserViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var userListView: UIView!
    let presenter = UserPresenter(userService: UserService())
    var usersListStorage = [UserList]()
    var usersList = [UsersModel]()
    var userDetails  : UserDetailModel?
    var userName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func allUsersTapped(_ sender: UIBarButtonItem) {
        presenter.getUsersList()
    }
    
    //MARK: - Custom Functions
    func config(){
        tableView?.dataSource = self
        tableView?.delegate = self
        activityIndicator?.hidesWhenStopped = true
        presenter.attachView(view: self)
        presenter.getUsersList()
    }

}

//MARK: - UITableView Delegates & DataSoruce
extension UserViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersListStorage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        let userViewData = usersListStorage[indexPath.row]
        cell.loginNameLabel?.text = userViewData.login
        if let url = userViewData.avatar_url {
            cell.avatarImageView.kf.setImage(with: URL(string:url))
        }
        else{
            cell.avatarImageView.image = UIImage(named: "defaultUserImg")
        }
        cell.avatarImageView.setRounded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.getUserDetails(userName:usersListStorage[indexPath.row].login!)
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
}

//MARK: - Protocols Implementation
extension UserViewController: UserView {
    
    func setUsersFromStorage(users: [UserList]) {
        usersListStorage = users
        userListView.isHidden = false
        tableView?.reloadData()
    }
    func setEmptyUsers() {
        tableView?.isHidden = true
    }
    
    func setUserDetails(userDetails: UserDetailModel) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller: UserDetailViewController = storyboard.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
        controller.userDetails = userDetails
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func startLoading() {
        // Show your loader
        activityIndicator?.startAnimating()
    }
    
    func finishLoading() {
        // Dismiss your loader
        activityIndicator?.stopAnimating()
    }
    
    func showError(errorMessage: String){
        Helper.showToast(controller: self, message: errorMessage)
    }
    
}

//MARK: - UIImageView
extension UIImageView {
    
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2)
        self.layer.masksToBounds = true
    }
}
