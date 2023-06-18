import ProjectDescription

let project = Project(
    name: "GitHubSearch",
    organizationName: nil,
    targets: [
        Target(
            name: "GitHubSearch",
            platform: .iOS,
            product: .framework,
            bundleId: "com.kjh.assignment.feature.GitHubSearch",
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
            ]
        )
    ]
)
