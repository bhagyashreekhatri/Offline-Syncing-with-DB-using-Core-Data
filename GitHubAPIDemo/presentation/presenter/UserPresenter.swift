//
//  UserView.swift
//  GitHubAPIDemo
//
//  Created by Bhagyashree Haresh Khatri on 22/08/2019.
//  Copyright © 2019 Bhagyashree Haresh Khatri. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol UserView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func showError(errorMessage: String)
    func setUsersFromStorage(users: [UserList])
    func setUserDetails(userDetails: UserDetailModel)
    func setEmptyUsers()
}

class UserPresenter {
    private let userService:UserService
    weak private var userView : UserView?
    
    init(userService:UserService) {
        self.userService = userService
    }
    
    func attachView(view:UserView) {
        userView = view
    }
    
    func detachView() {
        userView = nil
    }
    
    func getUsersList() {
        self.userView?.startLoading()
        userService.callAPIGetUsers(
            onSuccess: { (users) in
                // Clear storage and save managed object instances
                self.clearStorage()
                self.save(users:users)
                if let usersList = self.fetchFromStorage() {
                    DispatchQueue.main.async {
                        self.userView?.finishLoading()
                        if(usersList.count == 0){
                           self.userView?.setEmptyUsers()
                        }
                        else{
                            self.userView?.setUsersFromStorage(users: usersList)
                        }
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.userView?.finishLoading()
                        self.userView?.showError(errorMessage: "Something went wrong")
                    }
                }
                
            },
            onFailure: { (errorMessage) in
                if let usersList = self.fetchFromStorage() {
                    DispatchQueue.main.async {
                        self.userView?.finishLoading()
                        self.userView?.showError(errorMessage: errorMessage)
                        if(usersList.count == 0){
                            self.userView?.setEmptyUsers()
                        }
                        else{
                            self.userView?.setUsersFromStorage(users: usersList)
                        }
                    }
                }
            }
        )
    }
    
    
    func getUserDetails(userName:String) {
        self.userView?.startLoading()
        userService.callAPIGetUserDetail(userName:userName,
            onSuccess: { (userDetailsResponse) in
                DispatchQueue.main.async {
                    self.userView?.finishLoading()
                    self.userView?.setUserDetails(userDetails: userDetailsResponse)
                }
        },
            onFailure: { (errorMessage) in
                DispatchQueue.main.async {
                    self.userView?.finishLoading()
                    self.userView?.showError(errorMessage: errorMessage)
                }
        })
    }
    
    //MARK: Save in core data
    
    func save(users: [UsersModel]){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "UserList", in: managedContext)!
        for person in users{
            let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
            user.setValue(person.id, forKeyPath: "id")
            user.setValue(person.login, forKey: "login")
            user.setValue(person.node_id, forKey: "node_id")
            user.setValue(person.avatar_url, forKey: "avatar_url")
            user.setValue(person.gravatar_id, forKey: "gravatar_id")
            user.setValue(person.url, forKey: "url")
            user.setValue(person.html_url, forKey: "html_url")
            user.setValue(person.followers_url, forKeyPath: "followers_url")
            user.setValue(person.following_url, forKey: "following_url")
            user.setValue(person.gists_url, forKey: "gists_url")
            user.setValue(person.starred_url, forKey: "starred_url")
            user.setValue(person.subscriptions_url, forKey: "subscriptions_url")
            user.setValue(person.organizations_url, forKey: "organizations_url")
            user.setValue(person.repos_url, forKey: "repos_url")
            user.setValue(person.events_url, forKey: "events_url")
            user.setValue(person.received_events_url, forKey: "received_events_url")
            user.setValue(person.type, forKey: "type")
            user.setValue(person.site_admin, forKey: "site_admin")
        }
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //MARK: Fetch from core data
    
    func fetchFromStorage() -> [UserList]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserList")
        request.returnsObjectsAsFaults = false
        do {
            let users = try managedContext.fetch(request)
            return users as? [UserList]
        } catch let error {
            print(error)
            return nil
        }
    }
    
    //MARK: Empty Data of Core Data
    
    func clearStorage() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let isInMemoryStore = appDelegate.persistentContainer.persistentStoreDescriptions.reduce(false) {
            return $0 ? true : $1.type == NSInMemoryStoreType
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserList")
        // NSBatchDeleteRequest is not supported for in-memory stores
        if isInMemoryStore {
            do {
                let users = try managedContext.fetch(fetchRequest)
                for user in users {
                    managedContext.delete(user as! NSManagedObject)
                }
            } catch let error as NSError {
                print(error)
            }
        } else {
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try managedContext.execute(batchDeleteRequest)
            } catch let error as NSError {
                print(error)
            }
        }
    }
}
