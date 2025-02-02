import PackageDescription

let package = Package(
    name: "text-adventure-swift",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
       .Package(url: "https://github.com/IBM-Swift/SwiftyJSON.git", majorVersion: 17),
       .Package(url: "https://github.com/onevcat/Rainbow", majorVersion: 3),
       .Package(url: "https://github.com/kylef/PathKit", "0.9.1"),
       .Package(url: "https://github.com/andybest/linenoise-swift", "0.0.3")
    ]
)
