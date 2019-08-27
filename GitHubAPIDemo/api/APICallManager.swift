//
//  APICallManager.swift
//  GitHubAPIDemo
//
//  Created by Bhagyashree Haresh Khatri on 22/08/2019.
//  Copyright © 2019 Bhagyashree Haresh Khatri. All rights reserved.
//

import Alamofire
import SwiftyJSON
import Foundation

let API_BASE_URL = "https://api.github.com"

class APICallManager {
    static let instance = APICallManager()
    
    enum RequestMethod {
        case get
        case post
    }
    
    enum Endpoint: String {
        case Users = "/users"
        case SearchUser = "/search/users"
    }
    
    // MARK: GET USERS LIST API
    func callAPIGetUsers(onSuccess successCallback: ((_ users: [UsersModel]) -> Void)?,
                          onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        
        // Build URL
        let url = API_BASE_URL + Endpoint.Users.rawValue
        
        // call API
        self.createRequest(
            url, method: .get, headers: nil, parameters: nil,
            onSuccess: {(responseObject: JSON) -> Void in
                // Create dictionary
                if let responseDict = responseObject.arrayObject {
                    let userDict = responseDict as! [[String:AnyObject]]
                    
                    // Create object
                    var data = [UsersModel]()
                    for item in userDict {
                        let single = UsersModel.build(item)
                        data.append(single)
                    }
                    
                    // Fire callback
                    successCallback?(data)
                } else {
                    failureCallback?("An error has occured.")
                }
            },
            onFailure: {(errorMessage: String) -> Void in
                failureCallback?(errorMessage)
            }
        )
    }
    
    // MARK: GET SEARCH USER API
    func callAPISearchUser(userName:String,onSuccess successCallback: ((_ users: [UsersModel]) -> Void)?,
                         onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        
        // Build URL
        let url = API_BASE_URL + Endpoint.SearchUser.rawValue + "?q=" + userName
        
        // call API
        self.createRequest(
            url, method: .get, headers: nil, parameters: nil,
            onSuccess: {(responseObject: JSON) -> Void in
                // Create dictionary
                if let response = responseObject.dictionaryObject{
                    let userDict = UsersModel.loadFromArraysDictionary(response: response as [String : AnyObject])
                    successCallback?(userDict)
                }
                else {
                    failureCallback?("An error has occured.")
                }
        },
            onFailure: {(errorMessage: String) -> Void in
                failureCallback?(errorMessage)
        }
        )
    }
    
    
    // MARK: GET USER DETAILS API
    func callAPIGetUserDetail(userName:String,onSuccess successCallback: ((_ user: UserDetailModel) -> Void)?,
                          onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        
        // Build URL
        let url = API_BASE_URL + Endpoint.Users.rawValue + "/" + userName
        
        // call API
        self.createRequest(
            url, method: .get, headers: nil, parameters: nil,
            onSuccess: {(responseObject: JSON) -> Void in
                // Create dictionary
                if let responseDict = responseObject.dictionaryObject {
                    let userDetailDict = responseDict as [String : AnyObject]
                    
                    let data =  UserDetailModel.build(userDetailDict)
                    
                    // Fire callback
                    successCallback?(data)
                } else {
                    failureCallback?("An error has occured.")
                }
        },
            onFailure: {(errorMessage: String) -> Void in
                failureCallback?(errorMessage)
        }
        )
    }
    
    // MARK: Request Handler
    // Create request
    func createRequest(
        _ url: String,
        method: HTTPMethod,
        headers: [String: String]?,
        parameters: AnyObject?,
        onSuccess successCallback: ((JSON) -> Void)?,
        onFailure failureCallback: ((String) -> Void)?
        ) {
        
        Alamofire.request(url, method: method).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                successCallback?(json)
            case .failure(let error):
                if let callback = failureCallback {
                    // Return
                    callback(error.localizedDescription)
                }
            }
        }
    }
}
