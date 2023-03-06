//
//  CreateMessageBoard.swift
//  
//
//  Created by 范喬智 on 2023/3/3.
//

import Foundation
import Fluent

struct CreateMessageBoard: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("messageBoard")
            .id()
            .field("accountId", .uuid)
            .field("message", .string)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("messageBoard").delete()
    }
}

struct UpdateMessageBoard: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("messageBoard")
            .field("deleted_at", .datetime)
            .update()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("messageBoard")
            .deleteField("deleted_at")
            .update()
    }
}

