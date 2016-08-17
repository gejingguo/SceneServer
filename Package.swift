import PackageDescription

let package = Package(
    name: "SceneServer",
    targets: [
        Target(name: "Util", dependencies: []),
        Target(name: "Error", dependencies: []),
        Target(name: "Info", dependencies: ["Util", "Error"]),
        Target(name: "Scene", dependencies: ["Info", "Util", "Error"]),
        Target(name: "SceneServer", dependencies: ["Scene", "Info", "Util", "Error"]),
    ],
    dependencies: [
        .Package(url: "https://github.com/gejingguo/SwiftyJSON", majorVersion: 3, minor: 0),
        //.Package(url: "../swift-uv", majorVersion: 1),
    ]
)
