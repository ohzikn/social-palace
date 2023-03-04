//
//  CourseInformation.swift
//  
//
//  Created by 范喬智 on 2023/3/5.
//

import Foundation
import Vapor
import Fluent

final class CourseInformation: Model {
    static let schema: String = "courseInformation"
    
    @ID(key: .id)
    var id: UUID?
    
    // related account uuid
    @Field(key: "accountId")
    var accountId: UUID
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
}
