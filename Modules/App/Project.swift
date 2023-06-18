import ProjectDescription

let project = Project(
    name: "App",
    organizationName: nil,
    targets: [
        Target(
            name: "App",
            platform: .iOS,
            product: .app,
            bundleId: "com.kjh.assignment",
            deploymentTarget: .iOS(targetVersion: "13.0", devices: .iphone),
            infoPlist: .extendingDefault(with: [
                "UILaunchStoryboardName": "LaunchScreen"
            ]),
            sources: [
                .glob(
                    .relativeToManifest("Sources/**/*")
                )
            ],
            resources: [
                .glob(
                    pattern: .relativeToManifest("Resources/**/*")
                )
            ],
            dependencies: [
                .project(target: "Dependency", path: .relativeToRoot("Modules/Dependency/Dependency")),

                .project(target: "CoreNetwork", path: .relativeToRoot("Modules/Core/Network")),
                .project(target: "CoreView", path: .relativeToRoot("Modules/Core/View")),
                .project(target: "CoreContainer", path: .relativeToRoot("Modules/Core/CoreContainer")),

                .project(target: "GitHubProfile", path: .relativeToRoot("Modules/Feature/GitHubProfile")),
                .project(target: "GitHubSearch", path: .relativeToRoot("Modules/Feature/GitHubSearch")),
                .project(target: "MainTab", path: .relativeToRoot("Modules/Feature/MainTab")),
                .project(target: "FeatureContainer", path: .relativeToRoot("Modules/Feature/FeatureContainer")),
            ]
        )
    ]
)
