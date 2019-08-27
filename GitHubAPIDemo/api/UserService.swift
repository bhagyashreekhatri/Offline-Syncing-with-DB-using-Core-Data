//
//  UserService.swift
//  GitHubAPIDemo
//
//  Created by Bhagyashree Haresh Khatri on 22/08/2019.
//  Copyright © 2019 Bhagyashree Haresh Khatri. All rights reserved.
//

import Foundation

class UserService {
    
    public func callAPIGetUsers(onSuccess successCallback: ((_ users: [UsersModel]) -> Void)?,
                                 onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APICallManager.instance.callAPIGetUsers(
            onSuccess: { (users) in
                successCallback?(users)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
    
    public func callAPIGetUserDetail(userName:String,onSuccess successCallback: ((_ user: UserDetailModel) -> Void)?,
                                     onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APICallManager.instance.callAPIGetUserDetail(userName:userName,
            onSuccess: { (user) in
                successCallback?(user)
        },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
        }
        )
    }
    
}
