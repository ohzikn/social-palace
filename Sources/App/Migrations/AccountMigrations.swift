//
//  File.swift
//  
//
//  Created by George on 2023/3/1.
//

import Foundation
import Fluent

struct CreateAccount: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("accounts")
            .id()
            .field("userId", .string)
            .field("userName", .string)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("accounts").delete()
    }
}

struct UpdateAccount: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("accounts")
            .field("deleted_at", .datetime)
            .update()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("accounts")
            .deleteField("deleted_at")
            .update()
    }
}
