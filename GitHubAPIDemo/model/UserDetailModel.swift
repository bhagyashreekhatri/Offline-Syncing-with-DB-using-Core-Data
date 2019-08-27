//
//  UserDetailModel.swift
//  GitHubAPIDemo
//
//  Created by Bhagyashree Haresh Khatri on 22/08/2019.
//  Copyright © 2019 Bhagyashree Haresh Khatri. All rights reserved.
//


import Foundation

class UserDetailModel {
    var login: String?
    var id: Int?
    var node_id: String?
    var avatar_url: String?
    var gravatar_id: String?
    var url: String?
    var html_url: String?
    var followers_url: String?
    var following_url: String?
    var gists_url: String?
    var starred_url: String?
    var subscriptions_url: String?
    var organizations_url: String?
    var repos_url: String?
    var events_url: String?
    var received_events_url: String?
    var type: String?
    var site_admin: Bool?
    var name: String?
    var company: String?
    var blog: String?
    var location: String?
    var email: String?
    var hireable: String?
    var bio: String?
    var public_repos: Int?
    var public_gists: Int?
    var followers: Int?
    var following: Int?
    var created_at: String?
    var updated_at: String?
    
    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject]) {
        if let login = dict["login"] as? String {
            self.login = login
        }
        if let id = dict["id"] as? Int {
            self.id = id
        }
        if let node_id = dict["node_id"] as? String {
            self.node_id = node_id
        }
        if let avatar_url = dict["avatar_url"] as? String {
            self.avatar_url = avatar_url
        }
        if let gravatar_id = dict["gravatar_id"] as? String {
            self.gravatar_id = gravatar_id
        }
        if let url = dict["url"] as? String {
            self.url = url
        }
        if let html_url = dict["html_url"] as? String {
            self.html_url = html_url
        }
        if let followers_url = dict["followers_url"] as? String {
            self.followers_url = followers_url
        }
        if let following_url = dict["following_url"] as? String {
            self.following_url = following_url
        }
        if let gists_url = dict["gists_url"] as? String {
            self.gists_url = gists_url
        }
        if let starred_url = dict["starred_url"] as? String {
            self.starred_url = starred_url
        }
        if let subscriptions_url = dict["subscriptions_url"] as? String {
            self.subscriptions_url = subscriptions_url
        }
        if let organizations_url = dict["organizations_url"] as? String {
            self.organizations_url = organizations_url
        }
        if let repos_url = dict["repos_url"] as? String {
            self.repos_url = repos_url
        }
        if let events_url = dict["events_url"] as? String {
            self.events_url = events_url
        }
        if let received_events_url = dict["received_events_url"] as? String {
            self.received_events_url = received_events_url
        }
        if let type = dict["type"] as? String {
            self.type = type
        }
        if let site_admin = dict["site_admin"] as? Bool {
            self.site_admin = site_admin
        }
        if let name = dict["name"] as? String {
            self.name = name
        }
        if let company = dict["company"] as? String {
            self.company = company
        }
        if let blog = dict["blog"] as? String {
            self.blog = blog
        }
        if let location = dict["location"] as? String {
            self.location = location
        }
        if let email = dict["email"] as? String {
            self.email = email
        }
        if let hireable = dict["hireable"] as? String {
            self.hireable = hireable
        }
        if let bio = dict["bio"] as? String {
            self.bio = bio
        }
        if let public_repos = dict["public_repos"] as? Int {
            self.public_repos = public_repos
        }
        if let public_gists = dict["public_gists"] as? Int {
            self.public_gists = public_gists
        }
        if let followers = dict["followers"] as? Int {
            self.followers = followers
        }
        if let following = dict["following"] as? Int {
            self.following = following
        }
        if let created_at = dict["created_at"] as? String {
            self.created_at = created_at
        }
        if let updated_at = dict["updated_at"] as? String {
            self.updated_at = updated_at
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> UserDetailModel {
        let userDetails = UserDetailModel()
        userDetails.loadFromDictionary(dict)
        return userDetails
    }
}


