import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    app.get("accounts") { req async throws in
        try await Account.query(on: req.db).all()
    }
}
