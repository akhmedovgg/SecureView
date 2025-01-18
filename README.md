<div align="center">
  <img src="https://i.ibb.co/3cRjT0V/play-store-512.png" alt="" width="256" />
  <h1>SecureView</h1>
</div>

SecureView is a Swift package designed to safeguard sensitive content in your iOS applications without interrupting the user experience. It replaces the content captured in screenshots or screen recordings with a customizable alternate view while leaving the user's screen unaffected. This ensures that private information remains secure while users continue to interact with the app normally.

## Contents

- [Preview](#preview)
- [Features](#features)
- [Requirements](#requirements)
- [Communication](#communication)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Preview

| <img src="https://i.ibb.co/L9zMJmR/i-Pad-Pro-12-9-2.png" alt="" width="768" /> |
| - |
| This Swift package allows developers to protect sensitive content by specifying a `contentView` for on-screen display and a `screenshotView` to appear in screenshots, with the option to toggle screenshot restrictions dynamically using the `isScreenshotDisabled` property. |

## Features

- [x] Toggler to prevent screenshots at runtime
- [x] UIKit support
- [x] Auto Layout support
- [x] Frame-based layout (without Auto Layout) support
- [x] SwiftUI support
- [x] Prepared for Swift 6 and Swift Concurrency (strict mode)

## Requirements

- iOS 12.0+
- Xcode 10.0+
- Swift 5.0+

## Communication

- If you **need help**, you can contact to developer using [Telegram](https://t.me/akhmedovgg) messenger
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.


## Installation

### Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

> Xcode 11+ is required to build SecureView using Swift Package Manager.

To integrate SecureView into your Xcode project using Swift Package Manager, add it to the dependencies value of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/akhmedovgg/SecureView", .upToNextMajor(from: "1.0.0"))
]
```

### Manually

If you prefer not to use either of the aforementioned dependency managers, you can integrate SecureView into your project manually.

## Usage

### UIKit


```swift
import UIKit

final class ExampleViewController: UIViewController {
    private let rootView: SecureView<AlphaView, BetaView> = {
        let alphaView = AlphaView()
        let betaView = BetaView()
        return SecureView<AlphaView, BetaView>(
            contentView: alphaView,
            screenshotView: betaView,
            isScreenshotDisabled: true
        )
    }()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        view.addSubview(rootView)
        NSLayoutConstraint.activate([
            rootView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 50),
            rootView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            rootView.widthAnchor.constraint(equalToConstant: 100),
            rootView.heightAnchor.constraint(equalToConstant: 100),
        ])
        rootView.translatesAutoresizingMaskIntoConstraints = false
    }
}

```

### SwiftUI

```swift
import SwiftUI

struct SampleView: View {
    @State private var isScreenshotDisabled = true
    
    var body: some View {
        ZStack {
            SecureCanvasView(
                isScreenshotDisabled: $isScreenshotDisabled,
                screenView: {
                    Color.red
                },
                screenshotView: {
                    Color.green
                }
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
        }
    }
}

```

## License

SecureView is released under the MIT license. See [LICENSE](./LICENSE.txt) for details.
