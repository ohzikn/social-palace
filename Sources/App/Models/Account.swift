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
    
    @Field(key: "cycuId")
    var cycuId: String
    
    init() { }
    
    init(id: UUID? = nil, cycuId: String) {
        self.id = id
        self.cycuId = cycuId
    }
}
