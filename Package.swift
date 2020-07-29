// swift-tools-version:5.2

import PackageDescription

let package = Package(
  name: "Chess",
  products: [
    .library(name: "Chess", targets: ["Chess"]),
  ],
  targets: [
    .target(name: "Chess", dependencies: [])
  ]
)