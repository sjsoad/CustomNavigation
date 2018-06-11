//
//  PresentationController.swift
//  SKUtils
//
//  Created by Sergey on 07.06.2018.
//  Copyright © 2018 Sergey Kostyan. All rights reserved.
//

import UIKit

public enum VerticalPosition: Equatable {
    case top
    case center
    case bottom
    case custom(yPosition: CGFloat)
}

public typealias DimmingViewTapEventHandler = ((UITapGestureRecognizer) -> Void)

public protocol PresentationControlling {
    
    var verticalPosition: VerticalPosition { get set }
    var percentageOfWidth: CGFloat { get set }
    var dimmingViewTapEventHandler: DimmingViewTapEventHandler? { get set }
    func configuredDimmingView() -> UIView?
    func addDimmingViewToView()
    func showDimmingView()
    func hideDimmingView()
}

open class DefaultPresentationController: UIPresentationController, PresentationControlling {
    
    private lazy var dimmingView: UIView? = { [unowned self] in
        return configuredDimmingView()
    }()
    
    // MARK: - Utils -
    
    public var verticalPosition: VerticalPosition = .center
    public var percentageOfWidth: CGFloat = 0.9
    public var dimmingViewTapEventHandler: DimmingViewTapEventHandler?
    
    public func configuredDimmingView() -> UIView? {
        let dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        dimmingView.alpha = 0.0
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        dimmingView.addGestureRecognizer(recognizer)
        
        return dimmingView
    }
    
    public func addDimmingViewToView() {
        guard let dimmingView = dimmingView else { return }
        containerView?.insertSubview(dimmingView, at: 0)
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimmingView]|", options: [], metrics: nil,
                                                                   views: ["dimmingView": dimmingView]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimmingView]|", options: [], metrics: nil,
                                                                   views: ["dimmingView": dimmingView]))
    }
    
    public func showDimmingView() {
        changeDimmingView(alpha: 1)
    }
    
    public func hideDimmingView() {
        changeDimmingView(alpha: 0)
    }
    
    // MARK: - Private -
    
    private func changeDimmingView(alpha: CGFloat) {
        guard let dimmingView = dimmingView else { return }
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = alpha
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            dimmingView.alpha = alpha
        })
    }
    
    // MARK: - Actions -
    
    @objc dynamic func handleTap(_ recognizer: UITapGestureRecognizer) {
        guard let dimmingViewTapEventHandler = dimmingViewTapEventHandler else {
            presentingViewController.dismiss(animated: true)
            return
        }
        dimmingViewTapEventHandler(recognizer)
    }
    
    // MARK: - UIPresentationController -
    
    override open func presentationTransitionWillBegin() {
        addDimmingViewToView()
        showDimmingView()
    }
    
    override open func dismissalTransitionWillBegin() {
        hideDimmingView()
    }
    
    override open func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override open var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        let frameSize = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView.bounds.size)
        var origin = CGPoint.zero
        switch verticalPosition {
        case .top:
            origin = CGPoint(x: (containerView.frame.width - frameSize.width)/2, y: 0)
        case .bottom:
            origin = CGPoint(x: (containerView.frame.width - frameSize.width)/2, y: containerView.frame.maxY - frameSize.height)
        case .custom(let yPosition):
            origin = CGPoint(x: (containerView.frame.width - frameSize.width)/2, y: yPosition)
        case .center:
            origin = CGPoint(x: (containerView.frame.width - frameSize.width)/2, y: (containerView.frame.height - frameSize.height)/2)
        }
        return CGRect(origin: origin, size: frameSize)
    }
    
    override open func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return presentedViewController.view.systemLayoutSizeFitting(CGSize(width: parentSize.width * percentageOfWidth, height: 0),
                                                                    withHorizontalFittingPriority: .defaultHigh,
                                                                    verticalFittingPriority: .defaultLow)
    }
    
}
