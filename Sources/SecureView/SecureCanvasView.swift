//
//  SecureCanvasView.swift
//  SecureView
//
//  Created by Sherzod Akhmedov on 18/01/25.
//

#if canImport(SwiftUI)

import Foundation
import SwiftUI

@available(iOS 13.0, *)
public struct SecureCanvasView<ScreenView: View, ScreenshotView: View>: UIViewRepresentable {
    
    /// Parameter that marks content as protected. If the value is `true`, when a user takes a screenshot, the `screenshotView` will be displayed instead of the `contentView`. Otherwise, the content will be visible in the screenshot instead of the `screenshotView`
    var isScreenshotDisabled: Binding<Bool>
    
    /// The view that will be visible on the user's screen of the device
    public var screenView: () -> ScreenView
    
    /// The view that will be used for screenshots. You can set a custom view for screenshots if desired. The default value is `UIView()` (black screen).
    public var screenshotView: () -> ScreenshotView
    
    /// Creates a view with a secure canvas to prevent screenshots
    ///
    /// - Parameters:
    ///   - contentView: The view that will be visible on the user's screen of the device
    ///   - screenshotView: The view that will be used for screenshots. You can set a custom view for screenshots if desired. The default value is `UIView()` (black screen).
    ///   - isScreenshotDisabled: Parameter that marks content as protected. If the value is `true`, when a user takes a screenshot, the `screenshotView` will be displayed instead of the `contentView`. Otherwise, the content will be visible in the screenshot instead of the `screenshotView`. The default value is `true`.
    ///
    public init(
        isScreenshotDisabled: Binding<Bool>,
        screenView: @escaping () -> ScreenView,
        screenshotView: @escaping () -> ScreenshotView
    ) {
        self.isScreenshotDisabled = isScreenshotDisabled
        self.screenView = screenView
        self.screenshotView = screenshotView
    }
    
    public func makeUIView(context: Context) -> SecureView<UIView, UIView> {
        let contentView = UIHostingController(rootView: screenView())
        let screenshotView = UIHostingController(rootView: screenshotView())
        return SecureView<UIView, UIView>(
            contentView: contentView.view,
            screenshotView: screenshotView.view,
            isScreenshotDisabled: isScreenshotDisabled.wrappedValue
        )
    }
    
    public func updateUIView(_ secureView: SecureView<UIView, UIView>, context: Context) {
        secureView.setScreenshotDisabled(isScreenshotDisabled.wrappedValue)
    }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview {
    @State var isScreenshotDisabled = true
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
#endif

#endif
