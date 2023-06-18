import ProjectDescription

let project = Project(
    name: "CoreNetwork",
    organizationName: nil,
    targets: [
        Target(
            name: "CoreNetwork",
            platform: .iOS,
            product: .framework,
            bundleId: "com.kjh.assignment.core.network",
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
                .project(target: "Dependency", path: .relativeToRoot("Modules/Dependency/Dependency"))
            ]
        )
    ]
)

