import ProjectDescription

let project = Project(
    name: "Dependency",
    organizationName: nil,
    packages: [
        // Common
        .package(url: "https://github.com/Swinject/Swinject", .exact("2.8.3")),
        .package(url: "https://github.com/devxoul/URLNavigator", .exact("2.4.1")),

        // Network
        .package(url: "https://github.com/Moya/Moya", .exact("15.0.3")),

        // UI
        .package(url: "https://github.com/SnapKit/SnapKit", .exact("5.6.0")),
        .package(url: "https://github.com/evgenyneu/keychain-swift", .exact("20.0.0")),
        .package(url: "https://github.com/onevcat/Kingfisher", .exact("7.8.0")),

        // Rx
        .package(url: "https://github.com/ReactiveX/RxSwift", .exact("6.6.0")),
        .package(url: "https://github.com/RxSwiftCommunity/RxDataSources", .exact("5.0.2")),
        .package(url: "https://github.com/ReactorKit/ReactorKit", .exact("3.2.0")),
    ],
    targets: [
        Target(
            name: "Dependency",
            platform: .iOS,
            product: .framework,
            bundleId: "com.kjh.assignment.dependency.Dependency",
            deploymentTarget: .iOS(targetVersion: "13.0", devices: .iphone),
            sources: [
                .glob(
                    .relativeToManifest("Sources/**/*")
                )
            ],
            resources: [
                .glob(
                    pattern: .relativeToManifest("Resources/**/*"),
                    excluding: [
                        .relativeToManifest("Resources/dummy.txt")
                    ]
                )
            ],
            dependencies: [
                .package(product: "Swinject"),
                .package(product: "URLNavigator"),
                .package(product: "Moya"),
                .package(product: "RxMoya"),
                .package(product: "SnapKit"),
                .package(product: "KeychainSwift"),
                .package(product: "Kingfisher"),
                .package(product: "RxSwift"),
                .package(product: "RxDataSources"),
                .package(product: "ReactorKit"),
            ]
        )
    ]
)

