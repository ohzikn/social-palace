//
//  LessonInfoMigrations.swift
//  
//
//  Created by 范喬智 on 2023/3/7.
//

import Foundation
import Fluent

struct CreateLessonInfo: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("lessonInfo")
            .id()
            .field("accountId", .uuid)
            .field("allEnglish", .int8)
            .field("courseCode", .string)
            .field("courseName", .string)
            .field("crossName", .string)
            .field("crossType", .string)
            .field("departmentCode", .string)
            .field("departmentName", .string)
            .field("distanceCourse", .int8)
            .field("mgDepartmantCode", .string)
            .field("moocs", .int8)
            .field("nonStop", .int8)
            .field("notes", .string)
            .field("openCode", .string)
            .field("openCredit", .int8)
            .field("opQuality", .string)
            .field("opRmName1", .string)
            .field("opRmName2", .string)
            .field("opRmName123", .string)
            .field("opStdy", .string)
            .field("opTime1", .string)
            .field("opTime2", .string)
            .field("opTime123", .string)
            .field("opType", .string)
            .field("teacher", .string)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .field("deleted_at", .datetime)
            .create()
        
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("lessonInfo")
            .delete()
    }
}
