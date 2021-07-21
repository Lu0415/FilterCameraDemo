//
//  UIViewExtension.swift
//  SMchat
//
//  Created by sameapple on 2019/11/15.
//  Copyright © 2019 sameapple. All rights reserved.
//

import Foundation
import UIKit
//import RxSwift
//import RxCocoa

//extension Reactive where Base: UIView {
//
//}

extension UIView {

    //MARK: - 改變x軸座標
    
    func slideX(x: CGFloat, duration: TimeInterval) {

        let yPosition = self.frame.origin.y
        let height = self.frame.height
        let width = self.frame.width

        UIView.animate(withDuration: duration, animations: {
            self.frame = CGRect(x: x, y: yPosition, width: width, height: height)
        })
    }
    
    func finishsSlideX(x: CGFloat, duration: TimeInterval) -> Bool {

        let yPosition = self.frame.origin.y
        let height = self.frame.height
        let width = self.frame.width

        UIView.animate(withDuration: duration, animations: {
            self.frame = CGRect(x: x, y: yPosition, width: width, height: height)
            
        })
        return true
    }
    
    //MARK: - 改變y軸座標
    func slideY(y: CGFloat, duration: TimeInterval) {

        let xPosition = self.frame.origin.x
        let height = self.frame.height
        let width = self.frame.width

        UIView.animate(withDuration: duration, animations: {
            self.frame = CGRect(x: xPosition, y: y, width: width, height: height)
        })
    }
    
    func roundCornersBottomLeftRight(cornerRadius: Double) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
     
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
     
    }
    
    func roundCornersTopLeftRight(cornerRadius: Double) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
     
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
     
    }
    
    //MARK: - UIView+Additions
    
    public var left: CGFloat {
        
        get {
            return self.frame.origin.x
        } set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    public var top: CGFloat {
        
        get {
            return self.frame.origin.y
        } set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    public var right: CGFloat {
        
        get {
            return self.frame.origin.x + self.frame.size.width
        } set {
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
    }
    
    public var bottom: CGFloat {
        
        get {
            return self.frame.origin.y + self.frame.size.height
        } set {
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
    }
    
    public var centerX: CGFloat {
        
        get {
            return self.center.x
        } set {
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    
    public var centerY: CGFloat {
        
        get {
            return self.center.y
        } set {
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }
    
    public var width: CGFloat {
        
        get {
            return self.frame.size.width
        } set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    public var height: CGFloat {
        
        get {
            return self.frame.size.height
        } set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    public var origin: CGPoint {
        
        get {
            return self.frame.origin
        } set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }
    
    public var size: CGSize {
        
        get {
            return self.frame.size
        } set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    
    func removeAllSubviews() {
        
        while self.subviews.count > 0 {
            let subView = self.subviews.first
            subView?.removeFromSuperview()
        }
    }
}

enum OscillatoryAnimationType {
    case bigger
    case smaller
}

extension UIView{
    var x: CGFloat {
        get {
            return frame.origin.x
        } set {
            var tempFrame: CGRect = frame
            tempFrame.origin.x = newValue
            frame = tempFrame
        }
    }
    
    var y: CGFloat {
        get {
            return frame.origin.y
        } set {
            var tempFrame: CGRect = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
        }
    }
    
    func createGenericShadowLayer(radius: CGFloat) -> CALayer {
        return self.createShadowLayer(shadowColor: UIColor.black, size: CGSize.init(width: 0, height: 2), opacity: 0.14, shadowRadius: 3, cornerRadius: radius)
    }
    
    func createShadowLayer(shadowColor: UIColor, size: CGSize, opacity: CGFloat, shadowRadius: CGFloat, cornerRadius: CGFloat) -> CALayer {
        let subLayer = CALayer.init()
        subLayer.frame = self.frame
        subLayer.cornerRadius = cornerRadius
        subLayer.backgroundColor = UIColor.white.cgColor
        subLayer.masksToBounds = false
        subLayer.shadowColor = shadowColor.cgColor
        subLayer.shadowOffset = size
        subLayer.shadowOpacity = Float(opacity)
        subLayer.shadowRadius = shadowRadius
        return subLayer
    }
    
    func createCorner(bounds: CGRect, rectCorner: UIRectCorner, cornerRadius: CGFloat){
        if self.layer.mask != nil {
            return
        }
        if bounds.width == 0 || bounds.height == 0 {
            return
        }
        let maskPath = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: rectCorner, cornerRadii: CGSize.init(width: cornerRadius, height: cornerRadius))
        let shapeLayer = CAShapeLayer.init()
        shapeLayer.path = maskPath.cgPath
        shapeLayer.frame = bounds
        self.layer.mask = shapeLayer
    }
}

extension UIImage {
    func fixOrientation() -> UIImage {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }
        
        var transform = CGAffineTransform.identity
        
        switch self.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: CGFloat(Double.pi));
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0);
            transform = transform.rotated(by: CGFloat(Double.pi / 2));
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height);
            transform = transform.rotated(by: CGFloat(-Double.pi / 2));
        case .up, .upMirrored:
            break
        default:
            break;
        }
        
        switch self.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1);
        default:
            break;
        }
        
        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        let ctx = CGContext(
            data: nil,
            width: Int(self.size.width),
            height: Int(self.size.height),
            bitsPerComponent: self.cgImage!.bitsPerComponent,
            bytesPerRow: 0,
            space: self.cgImage!.colorSpace!,
            bitmapInfo: UInt32(self.cgImage!.bitmapInfo.rawValue)
        )
        
        ctx!.concatenate(transform);
        
        switch self.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            // Grr...
            ctx?.draw(self.cgImage!, in: CGRect(x:0 ,y: 0 ,width: self.size.height ,height:self.size.width))
        default:
            ctx?.draw(self.cgImage!, in: CGRect(x:0 ,y: 0 ,width: self.size.width ,height:self.size.height))
            break;
        }
        
        // And now we just create a new UIImage from the drawing context
        let cgimg = ctx!.makeImage()
        let img = UIImage(cgImage: cgimg!)
        
        return img;
    }
}

