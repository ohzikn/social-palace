import Vapor
import Fluent
import FluentMySQLDriver

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // register routes
    try routes(app)
    
    let tlsConfig = {
        var tls = TLSConfiguration.makeClientConfiguration()
        tls.certificateVerification = .none
        return tls
    }()
    
    // register databases
    app.databases.use(.mysql(hostname: "10.0.0.4", username: "vapor", password: "nopassword", database: "social-palace", tlsConfiguration: tlsConfig), as: .mysql)
    
    app.migrations.add(CreateAccount())
}
