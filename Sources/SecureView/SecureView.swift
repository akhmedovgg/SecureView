//
//  SecureCanvasView.swift
//  SecureView
//
//  Created by Sherzod Akhmedov on 18/01/25.
//

import Foundation
import UIKit

public final class SecureView<ScreenView: UIView, ScreenshotView: UIView>: UIView {
    
    /// The view that will be visible on the user's screen of the device
    public let contentView: ScreenView
    
    /// The view that will be used for screenshots. You can set a custom view for screenshots if desired. The default value is `UIView()` (black screen).
    public let screenshotView: ScreenshotView
    
    /// Parameter that marks content as protected. If the value is `true`, when a user takes a screenshot, the `screenshotView` will be displayed instead of the `contentView`. Otherwise, the content will be visible in the screenshot instead of the `screenshotView`
    public private(set) var isScreenshotDisabled: Bool
    
    /// The `UITextField` that holds a secure canvas view
    private let textField = UITextField()
    
    /// Secured canvas view that hides contents from screenshot
    private var canvasView: UIView!
    
    // MARK: Initializers
    
    /// Creates a view with a secure canvas to prevent screenshots
    ///
    /// - Parameters:
    ///   - frame: The frame rectangle for the view, measured in points. The origin of the frame is relative to the superview in which you plan to add it. This method uses the frame rectangle to set the center and bounds properties accordingly.
    ///   - contentView: The view that will be visible on the user's screen of the device
    ///   - screenshotView: The view that will be used for screenshots. You can set a custom view for screenshots if desired. The default value is `UIView()` (black screen).
    ///   - isScreenshotDisabled: Parameter that marks content as protected. If the value is `true`, when a user takes a screenshot, the `screenshotView` will be displayed instead of the `contentView`. Otherwise, the content will be visible in the screenshot instead of the `screenshotView`. The default value is `true`.
    ///
    public init(
        frame: CGRect = .zero,
        contentView: ScreenView,
        screenshotView: ScreenshotView = UIView(),
        isScreenshotDisabled: Bool = true
    ) {
        self.contentView = contentView
        self.screenshotView = screenshotView
        self.isScreenshotDisabled = isScreenshotDisabled
        super.init(frame: frame)
        setupCanvasView()
        setupUI()
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        performLayout()
    }
    
    // MARK: Public methods
    
    public func setScreenshotDisabled(_ isScreenshotDisabled: Bool) {
        self.isScreenshotDisabled = isScreenshotDisabled
        self.textField.isSecureTextEntry = isScreenshotDisabled
    }
    
    // MARK: Private methods
    
    private func setupUI() {
        addSubview(screenshotView)
        addSubview(canvasView)
        canvasView.addSubview(contentView)
        setScreenshotDisabled(isScreenshotDisabled)
    }
    
    private func setupCanvasView() {
        guard let canvasView = textField.layer.sublayers?.first?.delegate as? UIView else {
            fatalError("Unable to extract secured canvas view")
        }
        canvasView.subviews.forEach { $0.removeFromSuperview() }
        self.canvasView = canvasView
        
    }
    
    private func performLayout() {
        screenshotView.frame = bounds
        canvasView.frame = screenshotView.bounds
        contentView.frame = canvasView.bounds
    }
}
