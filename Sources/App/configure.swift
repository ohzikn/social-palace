import Vapor
import Fluent
import FluentMySQLDriver
import NIOSSL

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // basic configurations
    app.http.server.configuration.hostname = "10.0.43.2"
    app.http.server.configuration.port = 8080
    app.http.server.configuration.supportVersions = [.two]
    
    // tls configuration
    let certificate = try NIOSSLCertificate.fromPEMFile("/etc/letsencrypt/live/zyozi.jp/cert.pem").first!
    let privateKey = try NIOSSLPrivateKey(file: "/etc/letsencrypt/live/zyozi.jp/privkey.pem", format: .pem)
    app.http.server.configuration.tlsConfiguration = TLSConfiguration.makeServerConfiguration(certificateChain: [.certificate(certificate)], privateKey: .privateKey(privateKey))
    
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
