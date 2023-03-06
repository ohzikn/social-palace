import Foundation
import Vapor
import Fluent

func routes(_ app: Application) throws {
    // TLS Certificate well-known
//    app.get(".well-known", "acme-challenge", "Z930vb-dGDYMaSI_rhovvtU9e0CLQzJRZFnEQNCD1yU") { req async -> String in
//        "Z930vb-dGDYMaSI_rhovvtU9e0CLQzJRZFnEQNCD1yU.zZfnBkxMezT5cLIDw2rZXTBKLHac7P3YBmqqYc5-SYk"
//    }
    
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    app.post("authenticate") { req async throws -> String in
        // Exchange authenticate token with user information.
        do {
            let credentials = try req.content.decode(HttpModels.Credentials.self)
            req.logger.info("Authenticated credentials: \(credentials)")
            
            let authAccount = Account(userId: credentials.userId, userName: credentials.userName)
            
            // Check if user existed on database
            req.logger.info("Querying existing records...")
            let accounts = try await Account.query(on: req.db)
                .filter(\.$userId == authAccount.userId)
                .filter(\.$userName == authAccount.userName)
                .all()
            
            // Add record to database if user not existed
            if accounts.isEmpty {
                req.logger.info("Creating account on database...")
                try await authAccount.create(on: req.db)
            }
            
            // Query database again to retrieve account uuid
            if let queryAccount = try await Account.query(on: req.db)
                .filter(\.$userId == authAccount.userId)
                .filter(\.$userName == authAccount.userName)
                .first() {
                // Generate new access token
                req.logger.info("Generating access token...")
                let uuid = UUID()
                RuntimeParameters.authenticatedSessions[uuid] = queryAccount
                return uuid.uuidString
            } else {
                req.logger.info("Query returns empty record.")
                throw Abort(.internalServerError)
            }
                
        } catch {
            throw Abort(.badRequest)
        }
    }
    
    app.post("messageBoard") { req async throws in
        let headerQuery = try req.query.decode(HttpModels.HttpHeaderQuery.self)
        guard let messageBoardCommand = HttpModels.MessageBoardCommands(rawValue: headerQuery.method ?? "") else {
            throw Abort(.badRequest)
        }
        switch messageBoardCommand {
        case .retrieve:
            return try await getMessageBoardItems(req: req)
        case .upload:
            do {
                let uploadRequest = try req.content.decode(HttpModels.MessageBoardUploadRequest.self)
                req.logger.info("\(uploadRequest)")
                let senderUuid: UUID = UUID(uuidString: uploadRequest.authenticateToken)!
                if let targetUser = RuntimeParameters.authenticatedSessions[senderUuid], let userId = targetUser.id {
                    if let message = uploadRequest.message, !message.isEmpty {
                        req.logger.info("Uploading message using sender token... \(senderUuid)")
                        try await MessageBoard(accountId: userId, message: message).create(on: req.db)
                    } else {
                        req.logger.info("Sender has uploaded an empty message.")
                        throw Abort(.badRequest)
                    }
                } else {
                    req.logger.info("Sender token is not authenticated. \(senderUuid)")
                    throw Abort(.badRequest)
                }
                req.logger.info("Message uploaded.")
            } catch {
                throw Abort(.badRequest)
            }
            return try await getMessageBoardItems(req: req)
        }
    }
}


private func getMessageBoardItems(req: Request) async throws -> HttpModels.MessageBoardResponse {
    do {
//        let tempAccountList = try await Account.query(on: req.db)
//            .all()
        req.logger.info("Querying message board contents...")
        let messages = try await MessageBoard.query(on: req.db)
            .sort(\.$updatedAt, .descending)
            .range(..<10)
            .join(Account.self, on: \Account.$id == \MessageBoard.$accountId)
            .all()
        
        var response = HttpModels.MessageBoardResponse()
        messages.forEach { item in
            let targetAccount = try? item.joined(Account.self)
            response.items.append(.init(userId: targetAccount?.userId, userName: targetAccount?.userName, message: item.message))
        }
//        let tempAccountList = try await Account.query(on: req.db)
        req.logger.info("Query completed.")
        return response
    } catch {
        req.logger.info("Query failed.")
        throw Abort(.internalServerError)
    }
}
