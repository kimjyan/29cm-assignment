import ProjectDescription

let project = Project(
    name: "MainTab",
    organizationName: nil,
    targets: [
        Target(
            name: "MainTab",
            platform: .iOS,
            product: .framework,
            bundleId: "com.kjh.assignment.feature.MainTab",
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
                .project(target: "Dependency", path: .relativeToRoot("Modules/Dependency/Dependency")),

                .project(target: "CoreNetwork", path: .relativeToRoot("Modules/Core/Network")),
                .project(target: "CoreView", path: .relativeToRoot("Modules/Core/View")),
                .project(target: "CoreContainer", path: .relativeToRoot("Modules/Core/CoreContainer")),

                .project(target: "GitHubSearch", path: .relativeToRoot("Modules/Feature/GitHubSearch")),
                .project(target: "GitHubProfile", path: .relativeToRoot("Modules/Feature/GitHubProfile")),
            ]
        )
    ]
)
