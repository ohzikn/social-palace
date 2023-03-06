//
//  File.swift
//  
//
//  Created by 范喬智 on 2023/3/3.
//

import Foundation
import Vapor
import Fluent

final class MessageBoard:  Model, Content {
    static let schema: String = "messageBoard"
    
    @ID(key: .id)
    var id: UUID?
    
    // related account uuid
    @Field(key: "accountId")
    var accountId: UUID
    
    @Field(key: "message")
    var message: String
    
    // Timestamps
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, accountId: UUID, message: String) {
        self.id = id
        self.accountId = accountId
        self.message = message
    }
}
