//
//  LessonInformation.swift
//  
//
//  Created by 范喬智 on 2023/3/5.
//

import Foundation
import Vapor
import Fluent

final class LessonInfo: Model {
    static let schema: String = "lessonInfo"
    
    @ID(key: .id)
    var id: UUID?
    
    // related account uuid
    @Field(key: "accountId")
    var accountId: UUID
    
    @OptionalField(key: "allEnglish")
    var allEnglish: Int?
    
    @OptionalField(key: "courseCode")
    var courseCode: String?
    
    @OptionalField(key: "courseName")
    var courseName: String?
    
    @OptionalField(key: "crossName")
    var crossName: String?
    
    @OptionalField(key: "crossType")
    var crossType: String?
    
    @OptionalField(key: "departmentCode")
    var departmentCode: String?
    
    @OptionalField(key: "departmentName")
    var departmentName: String?
    
    @OptionalField(key: "distanceCourse")
    var distanceCourse: Int?
    
    @OptionalField(key: "mgDepartmantCode")
    var mgDepartmantCode: String?
    
    @OptionalField(key: "moocs")
    var moocs: Int?
    
    @OptionalField(key: "nonStop")
    var nonStop: Int?
    
    @OptionalField(key: "notes")
    var notes: String?
    
    @OptionalField(key: "openCode")
    var openCode: String?
    
    @OptionalField(key: "openCredit")
    var openCredit: Int?
    
    @OptionalField(key: "opQuality")
    var opQuality: String?
    
    @OptionalField(key: "opRmName1")
    var opRmName1: String?
    
    @OptionalField(key: "opRmName2")
    var opRmName2: String?
    
    @OptionalField(key: "opRmName123")
    var opRmName123: String?
    
    @OptionalField(key: "opStdy")
    var opStdy: String?
    
    @OptionalField(key: "opTime1")
    var opTime1: String?
    
    @OptionalField(key: "opTime2")
    var opTime2: String?
    
    @OptionalField(key: "opTime123")
    var opTime123: String?
    
    @OptionalField(key: "opType")
    var opType: String?
    
    @OptionalField(key: "teacher")
    var teacher: String?
    
    // Timestamps
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?
}
