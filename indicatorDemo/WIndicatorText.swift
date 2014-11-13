//
//  WIndicatorText.swift
//  indicatorDemo
//
//  Created by wangshouye on 14/11/12.
//  Copyright (c) 2014年 wangshouye. All rights reserved.
//

import UIKit


class WIndicatorText: UIView {
    
    private let margin:Float = 20.0
    private let maxWidth:Float = Float(UIScreen.mainScreen().bounds.size.width) - 2 * 20

    private let labelFontSize:CGFloat = 16.0
    private var bgView: UIView?
    private var label: UILabel?
    
    private var labelText: String = ""
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(view:UIView, text:String, timeOut interval:NSTimeInterval) {
        
        self.init(frame: view.bounds)
        self.backgroundColor = UIColor.clearColor()

        self.labelText = text
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIDeviceOrientationDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserverForName(UIDeviceOrientationDidChangeNotification, object:nil, queue:NSOperationQueue.mainQueue(), usingBlock:{notification in
            
            self.frame =  self.superview!.bounds
            self.setNeedsDisplay()
        })
        

        var time = UInt64(interval) * NSEC_PER_SEC
        var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(time));

        dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
            
            UIView.animateWithDuration(interval, animations: { () -> Void in
                self.alpha = 0.0
            }, completion: { (isFinish ) -> Void in
                self.removeFromSuperview()
            })
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bgView = UIView()
        bgView?.backgroundColor = UIColor.blackColor()
        bgView?.layer.cornerRadius = 10.0
        bgView?.layer.masksToBounds = true
        self.addSubview(bgView!)
        
        label = UILabel()
        label!.font = UIFont.systemFontOfSize(labelFontSize)
        label!.adjustsFontSizeToFitWidth = false
        label!.textAlignment = NSTextAlignment.Center
        label!.opaque = false
        label!.backgroundColor = UIColor.clearColor()
        label!.textColor = UIColor.whiteColor()
        label!.numberOfLines = 0
        bgView!.addSubview(label!)
    }
    
    override func layoutSubviews () {
        
        var frame = self.bounds
        var tempString = NSString(string: self.labelText)

        var maxLabelSize = CGSize(width: 200, height: Int.max)

        let rect:CGRect = tempString.boundingRectWithSize(maxLabelSize,
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName:UIFont.systemFontOfSize(labelFontSize)],
            context: nil)

        let stringWidth:Float = Float(rect.size.width)
        let stringHeight:Float = Float(rect.size.height)

        var bgViewWidth = stringWidth + 2 * margin
        var bgViewHeight = stringHeight + 2 * margin
        var bgViewX:Float = (Float(frame.size.width) - ( bgViewWidth )) / 2
        var bgViewY:Float = (Float(frame.size.height) - (bgViewHeight )) / 2
        
        var labelX:Float = (bgViewWidth - stringWidth)/2
        var labelY:Float = (bgViewHeight - stringHeight)/2

        bgView!.frame = CGRect(x: CGFloat(bgViewX), y: CGFloat(bgViewY), width: CGFloat(bgViewWidth), height: CGFloat(bgViewHeight))
        label!.frame = CGRect(x: CGFloat(labelX), y: CGFloat(labelY), width: CGFloat(stringWidth), height: CGFloat(stringHeight))
        
        label!.text = labelText
    }

}


















