// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.
//swiftCLIUpdateTool
import PackageDescription

let package = Package(
    name: "swiftCLIUpdateTool",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0"),
        .package(url: "https://github.com/Alamofire/Alamofire.git",from: "5.6.4")
    ],
    targets: [

        .executableTarget(
            name: "swiftCLIUpdateTool",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Alamofire", package: "Alamofire"),
            ]),
        .testTarget(
            name: "swiftCLIUpdateToolTests",
            dependencies: ["swiftCLIUpdateTool","Alamofire"]),
    ]
)
