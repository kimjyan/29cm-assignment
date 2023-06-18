import ProjectDescription

let project = Project(
    name: "FeatureContainer",
    organizationName: nil,
    targets: [
        Target(
            name: "FeatureContainer",
            platform: .iOS,
            product: .framework,
            bundleId: "com.kjh.assignment.feature.container",
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
                .project(target: "CoreContainer", path: .relativeToRoot("Modules/Core/CoreContainer")),
                .project(target: "CoreView", path: .relativeToRoot("Modules/Core/View")),

                .project(target: "GitHubProfile", path: .relativeToRoot("Modules/Feature/GitHubProfile")),
                .project(target: "GitHubSearch", path: .relativeToRoot("Modules/Feature/GitHubSearch")),
                .project(target: "MainTab", path: .relativeToRoot("Modules/Feature/MainTab")),
            ]
        )
    ]
)
