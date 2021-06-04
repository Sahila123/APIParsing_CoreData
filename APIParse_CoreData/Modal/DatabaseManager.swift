//
//  DatabaseManager.swift
//  APIParse_CoreData
//
//  Created by Mirajkar on 04/06/21.
//  Copyright © 2021 Mirajkar. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DatabaseManager {
    //MARK: Global variables
    
    static var shared = DatabaseManager()
    
    private init() {
        
    }
    
    var posts : [NSManagedObject] = []
    
    //MARK: Insert data to CoreData
    
    func saveData(postObject: Post)  {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Posts")
        fetchRequest.predicate = NSPredicate(format: "id = %d", postObject.id!)
        
        var results: [NSManagedObject] = []
        
        do {
            results = try managedContext.fetch(fetchRequest)
            if results.count == 0 {
                let postEntity = NSEntityDescription.entity(forEntityName: "Posts", in: managedContext)
                let post = NSManagedObject(entity: postEntity!, insertInto: managedContext)
                post.setValue(postObject.id, forKeyPath: "id")
                post.setValue(postObject.postId, forKeyPath: "postId")
                post.setValue(postObject.name, forKeyPath: "name")
                post.setValue(postObject.email, forKeyPath: "email")
                post.setValue(postObject.comment, forKeyPath: "comment")
                
                do {
                    try managedContext.save()
                    posts.append(post)
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            } else {
                //don't insert
            }
        } catch {
            print("error executing fetch request: \(error)")
        }
        
        
    }
    
    //MARK: Read data from CoreData
    
    func fetchPostsData() -> [NSManagedObject] {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Posts")
            do {
                posts = try managedContext.fetch(fetchRequest)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            return posts
        }
        return posts
    }
    
    func deleteObject(postObject: NSManagedObject) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext

        managedContext.delete(postObject)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    
}
