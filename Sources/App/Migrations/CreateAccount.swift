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
            .field("cycuId", .string)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("accounts").delete()
    }
}
