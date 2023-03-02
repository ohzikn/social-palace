import Vapor

func routes(_ app: Application) throws {
    // TLS Certificate well-known
    app.get(".well-known", "acme-challenge", "Z930vb-dGDYMaSI_rhovvtU9e0CLQzJRZFnEQNCD1yU") { req async -> String in
        "Z930vb-dGDYMaSI_rhovvtU9e0CLQzJRZFnEQNCD1yU.zZfnBkxMezT5cLIDw2rZXTBKLHac7P3YBmqqYc5-SYk"
    }
    
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
