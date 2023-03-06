//
//  File.swift
//  
//
//  Created by 范喬智 on 2023/3/3.
//

import Foundation
import Vapor

struct HttpModels {
    
    struct HttpHeaderQuery: Content {
        var method: String?
    }
    
    struct Credentials: Content {
        var userId: String
        var userName: String
    }
    
    enum MessageBoardCommands: String, CaseIterable {
        case retrieve
        case upload
    }
    
    struct MessageBoardUploadRequest: HttpMethodQueryBase, Content {
        var authenticateToken: String
        var message: String?
    }
    
    struct MessageBoardResponse: Content {
        var items: [MessageBoardItem] = []
        
        struct MessageBoardItem: Content {
            var userId: String?
            var userName: String?
            var message: String?
        }
    }
    
    enum LessonInfoCommands: String, CaseIterable {
        case retrieve
        case fetch
        case sync
    }
    
    struct LessonInfoUploadRequest: HttpMethodQueryBase, Content {
        var authenticateToken: String
        var items: [LessonInfo]
    }
}

protocol HttpMethodQueryBase {
    var authenticateToken: String { get set }
}
