//
//  NetworkManager.swift
//  APIParse_CoreData
//
//  Created by Mirajkar on 04/06/21.
//  Copyright © 2021 Mirajkar. All rights reserved.
//

import Foundation


class NetworkManager {
    //MARK: Global variables
    
    static var shared = NetworkManager()
    
    private init() { }
    
    var defaultSession = URLSession(configuration: .default)
    var dataTask : URLSessionTask?
    var posts : [Post] = []
    var errorMessage = ""
    
    //MARK:  API call
    
    func getPosts(completion : @escaping (String?) -> Void ) {
        
        dataTask?.cancel()
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments") else {
            return
        }
        
        dataTask = defaultSession.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                DispatchQueue.main.async {
                    self.insertPostsInCoreData(data: data)
                    completion("Done")
                }
            }
        })
        
        dataTask?.resume()
    }
    
    
    func insertPostsInCoreData(data: Data) {
        var response : [Any]?
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Array
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        guard let responseArray = response else {
            return
        }
        
        for postDict in responseArray {
            if let postDict = postDict as? [String : Any],
                let id = postDict["id"] as? Int,
                let postId = postDict["postId"] as? Int,
                let name = postDict["name"] as? String,
                let email = postDict["email"] as? String,
                let comment = postDict["body"] as? String {
                DatabaseManager.shared.saveData(postObject: Post(id: id, postId: postId, name: name, email: email, comment: comment))
            }
        }
    }
}
