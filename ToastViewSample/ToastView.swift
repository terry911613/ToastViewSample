//
//  ToastView.swift
//  Night Owl Dev
//
//  Created by Apple on 2020/2/27.
//  Copyright © 2018 Night Owl. All rights reserved.
//

import UIKit

public class ToastView: NibView {
    
    public enum Location {
        case bottom
        case top
    }

    private struct Constant {
        static let margin: CGFloat = 15
        static let delay: TimeInterval = 3 // 5
    }

    @IBOutlet weak var messageLabel: UILabel!
    
    public static func showNotification(message: String, textAlignment: NSTextAlignment = .left, location: Location = .bottom, delay: TimeInterval? = nil, displayedHandler: (()->())? = nil, dismissedHandler: (()->())? = nil) {
        if let windowScence = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let scenceDelegat = windowScence.delegate as? SceneDelegate,
            let window = scenceDelegat.window{
            
            showNotification(message: message, textAlignment: textAlignment, location: location, delay: delay, inView: window, displayedHandler: displayedHandler, dismissedHandler: dismissedHandler)
        }
    }

    public static func showNotification(message: String, textAlignment: NSTextAlignment = .left, location: Location = .bottom, delay: TimeInterval? = nil, inView view: UIView, displayedHandler: (()->())? = nil, dismissedHandler: (()->())? = nil) {
        let toast = ToastView(frame: view.bounds)
        toast.messageLabel.text = message
        toast.messageLabel.textAlignment = textAlignment
        let toastHeight = toast.messageLabel.sizeThatFits(CGSize(width: toast.messageLabel.frame.width, height: CGFloat.greatestFiniteMagnitude)).height + (Constant.margin * 2)
        let position = getPosition(withLocation: location, toastHeight: toastHeight, parentView: view)
        var frame = CGRect(origin: position.from, size: CGSize(width: view.frame.size.width, height: toastHeight))
        toast.frame = frame
        toast.autoresizingMask = [.flexibleWidth]
        toast.alpha = 0
        view.addSubview(toast)
        UIView.animate(withDuration: 0.3, animations: {
            frame.origin = position.to
            toast.frame = frame
            toast.alpha = 1
            let duration = delay ?? Constant.delay
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                UIView.animate(withDuration: 0.3, animations: {
                    frame.origin = position.from
                    toast.frame = frame
                    toast.alpha = 0
                }) { _ in
                    dismissedHandler?()
                    toast.removeFromSuperview()
                }
            }
        }) { _ in
            displayedHandler?()
        }
    }

    private static func getPosition(withLocation location: Location, toastHeight: CGFloat, parentView: UIView) -> (from: CGPoint, to: CGPoint) {
        var from: CGPoint
        var to: CGPoint
        switch location {
        case .bottom:
            from = CGPoint(x: 0, y: parentView.frame.size.height)
            to = CGPoint(x: 0, y: parentView.frame.size.height - toastHeight)
        case .top:
            from = CGPoint(x: 0, y: -toastHeight)
            to = CGPoint(x: 0, y: 0)
        }
        return (from, to)
    }

}
