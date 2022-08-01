
# Git-Trendo

An example app built with Swift to show trending git repositoires using clean architecture with MVVM-C in iOS.

## Documentation

![Platform](https://img.shields.io/badge/Platform-iOS-orange.svg)

![Languages](https://img.shields.io/badge/Language-Swift-orange.svg)

## Features

- [x]  Github Trending API Using Pagination
- [x]  Cached Response
- [x]  URL / JSON Parameter Encoding
- [x]  Testable Network Layer
- [x]  Dark Mode Support
- [x]  UI and Unit Tests

## Layers
* **Domain Layer** = Entities + Use Cases + Repositories Interfaces
* **Data Repositories Layer** = Repositories Implementations + API (Network)
* **Presentation Layer (MVVM)** = ViewModels + Views

## Requirements

- iOS 13.0 (Change this to a lower version in project settings if you are not on latest xcode IDE)
- Xcode 13+
- Swift 5+

## Clean Architecture using MVVM

![Alt text](README_FILES/architecture.png?raw=true "Clean Architecture Layers")

in Clean Architecture, we have different layers in the application. The main rule is not to have dependencies from inner layers to outers layers. The arrows pointing from outside to inside is the Dependency rule. There can only be dependencies from outer layer inward
After grouping all layers we have: Presentation, Domain and Data layers.
- #### Domain Layer 
  - Domain Layer (Business logic) is the inner-most part of the onion (without dependencies to other layers, it is totally isolated). It contains Entities(Business Models)
- #### Presentation Layer 
  - Presentation Layer contains UI (UIViewControllers or SwiftUI Views). Views are coordinated by ViewModels (Presenters). Presentation Layer depends only on the Domain Layer
- #### Data Layer
  - Data Layer contains Repository Implementations and one or many Data Sources. Repositories are responsible for coordinating data from different Data Sources. Data Source can be Remote or Local (for example persistent database). Data Layer depends only on the Domain Layer. In this layer, we can also add mapping of Network JSON Data (e.g. Decodable conformance) to Domain Models

- ### Dependency Direction

![Alt text](README_FILES/layers.png?raw=true "Modules Dependencies")

  - Presentation Layer -> Domain Layer <- Data Repositories Layer
  - Presentation Layer (MVVM) = ViewModels(Presenters) + Views(UI)
  - Domain Layer = Entities
  - Data Repositories Layer = Repositories Implementations + API(Network) + Persistence DB

## Dependencies
* [CocoaPods](https://cocoapods.org)
* [SDWebImage](https://github.com/SDWebImage/SDWebImage)
* [Lottie](https://github.com/airbnb/lottie-ios)
* [SkeletonView](https://github.com/Juanpe/SkeletonView)
