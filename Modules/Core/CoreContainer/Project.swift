import ProjectDescription

let project = Project(
    name: "CoreContainer",
    organizationName: nil,
    targets: [
        Target(
            name: "CoreContainer",
            platform: .iOS,
            product: .framework,
            bundleId: "com.kjh.assignment.core.container",
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
                .project(target: "CoreView", path: .relativeToRoot("Modules/Core/View"))
            ]
        )
    ]
)
