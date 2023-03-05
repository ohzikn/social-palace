import Vapor
import Fluent
import FluentMySQLDriver
import FluentSQLiteDriver
import NIOSSL

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // basic configurations
    app.http.server.configuration.hostname = app.environment == .production ? "10.0.43.2" : "10.0.1.2"
    app.http.server.configuration.port = 8080
    app.http.server.configuration.supportVersions = app.environment == .production ? [.two] : [.one]
    
    if app.environment == .production {
        // tls configuration (only in production mode)
        let certificate = try NIOSSLCertificate.fromPEMFile("/etc/letsencrypt/live/zyozi.jp/cert.pem").first!
        let privateKey = try NIOSSLPrivateKey(file: "/etc/letsencrypt/live/zyozi.jp/privkey.pem", format: .pem)
        app.http.server.configuration.tlsConfiguration = TLSConfiguration.makeServerConfiguration(certificateChain: [.certificate(certificate)], privateKey: .privateKey(privateKey))
    }
    
    // register databases
//    let tlsConfig = {
//        var tls = TLSConfiguration.makeClientConfiguration()
//        tls.certificateVerification = .none
//        return tls
//    }()
//    app.databases.use(.mysql(hostname: "127.0.0.1", username: "vapor-server", password: "nopassword", database: "social-palace", tlsConfiguration: tlsConfig), as: .mysql)
    if #available(macOS 13.0, *) {
        app.databases.use(.sqlite(.file((app.environment == .production ? FileManager.default.urls(for: .developerDirectory, in: .userDomainMask).first?.appending(path: "Databases/social-palace/db.social-palace").absoluteString : FileManager.default.urls(for: .developerDirectory, in: .userDomainMask).first?.appending(path: "Databases/social-palace/db.social-palace-dev").absoluteString) ?? "")), as: .sqlite)
    } else {
        // Fallback on earlier versions
        app.databases.use(.sqlite(.memory), as: .sqlite)
    }
    app.migrations.add(CreateAccount())
    app.migrations.add(CreateMessageBoard())
    
    // register routes
    try routes(app)
}
