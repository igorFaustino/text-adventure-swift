import PackageDescription

let package = Package(
    name: "text-adventure-swift",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
       .Package(url: "https://github.com/IBM-Swift/SwiftyJSON.git", majorVersion: 15),
       .Package(url: "https://github.com/onevcat/Rainbow", majorVersion: 3)
    ]
)
