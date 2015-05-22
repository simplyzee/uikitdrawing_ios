//
//  ViewController.swift
//  UIKitDrawing
//
//  Created by Zee on 22/05/2015.
//  Copyright (c) 2015 Zee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var tempImage: UIImageView!
    
    var gestureSwiped = false
    var lastPoint = CGPoint()
    
    /*var red     = CGFloat()
    var green   = CGFloat()
    var blue    = CGFloat()
    var brush   = CGFloat()
    var opacity = CGFloat()*/

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        gestureSwiped = false
        let touch = touches.first as? UITouch
        lastPoint = touch!.locationInView(self.view)
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        gestureSwiped = true
        
        let touch = touches.first as? UITouch
        var currentPoint = touch!.locationInView(self.view)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        tempImage.image?.drawInRect(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y)
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y)
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound)
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 6.0)
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0/255.0, 0.0/255.0, 0.0/255.0, 1.0);
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeNormal)
        
        CGContextStrokePath(UIGraphicsGetCurrentContext())
        tempImage.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImage.alpha = 1.0
        UIGraphicsEndImageContext()
        
        lastPoint = currentPoint
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if gestureSwiped == false {
            UIGraphicsBeginImageContext(self.view.frame.size)
            tempImage.image?.drawInRect(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
            
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 6.0);
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0/255.0, 0.0/255.0, 0.0/255.0, 1.0);
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
            CGContextStrokePath(UIGraphicsGetCurrentContext());
            CGContextFlush(UIGraphicsGetCurrentContext());
            
            tempImage.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }

        UIGraphicsBeginImageContext(self.mainImage.frame.size)
        mainImage.image?.drawInRect(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height), blendMode: kCGBlendModeNormal, alpha: 1.0)
        tempImage.image?.drawInRect(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height), blendMode: kCGBlendModeNormal, alpha: 1.0)
        mainImage.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImage.image = nil
        UIGraphicsEndImageContext()
    }
}

