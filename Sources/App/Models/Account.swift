//
//  Account.swift
//  
//
//  Created by George on 2023/3/1.
//

import Foundation
import Vapor
import Fluent

final class Account: Model, Content {
    // Name of the table or collection.
    static let schema: String = "accounts"
    
    // Unique identifier.
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "userId")
    var userId: String
    
    @Field(key: "userName")
    var userName: String
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, userId: String, userName: String) {
        self.id = id
        self.userId = userId
        self.userName = userName
    }
    
}
