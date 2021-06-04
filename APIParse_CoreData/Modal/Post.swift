//
//  Post.swift
//  APIParse_CoreData
//
//  Created by Mirajkar on 04/06/21.
//  Copyright © 2021 Mirajkar. All rights reserved.
//

import Foundation


struct Post {
    var id : Int?
    var postId : Int?
    var name : String?
    var email : String?
    var comment : String?

    
    init(id: Int?, postId: Int?, name:String?, email:String?, comment:String?) {
        self.id = id
        self.postId = postId
        self.name = name
        self.email = email
        self.comment = comment
    }
}
