//
//  WActivityIndicator.swift
//  indicatorDemo
//
//  Created by wangshouye on 14/11/13.
//  Copyright (c) 2014年 wangshouye. All rights reserved.
//

import UIKit

class WActivityIndicator: UIView {

    private let margin:Float = 20.0
    private let padding:Float = 4.0
    
    private let labelFontSize:CGFloat = 16.0
    
    private var indicator:UIView?
    private var contentView:UIView?
    private var bgView:UIView?
    
    private var width:Float = 0.0
    private var height:Float = 0.0
    
    private var label: UILabel?
    
    private var labelText = ""
    // ----------------------------------------------------------
    var text: String? {
        set{
            if newValue != nil {
                labelText = newValue!
            } else {
                labelText = ""
            }
            
            self.setNeedsLayout()
            self.setNeedsDisplay()
        }
        
        get {
            return labelText
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(view:UIView) {
        self.init(frame: view.bounds)
        self.backgroundColor = UIColor.clearColor()
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIDeviceOrientationDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserverForName(UIDeviceOrientationDidChangeNotification, object:nil, queue:NSOperationQueue.mainQueue(), usingBlock:{notification in
            
            self.frame =  self.superview!.bounds
            self.setNeedsDisplay()
        })
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bgView = UIView()
        bgView?.backgroundColor = UIColor.blackColor()
        bgView?.alpha = 0.0
        bgView?.layer.cornerRadius = 10.0
        bgView?.layer.masksToBounds = true
        self.addSubview(bgView!)
        
        contentView = UIView()
        contentView?.backgroundColor = UIColor.clearColor()
        contentView?.alpha = 0.0
        self.addSubview(contentView!)
        
        indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
        (indicator as UIActivityIndicatorView).startAnimating()
        
        contentView!.addSubview(indicator!)
        
        label = UILabel()
        label!.font = UIFont.systemFontOfSize(labelFontSize)
        label!.adjustsFontSizeToFitWidth = false
        label!.textAlignment = NSTextAlignment.Center
        label!.opaque = false
        label!.backgroundColor = UIColor.clearColor()
        label!.textColor = UIColor.whiteColor()
        
        contentView!.addSubview(label!)
    }
    
    override func layoutSubviews () {
        
        var frame = self.bounds
        var indicatorFrame = self.indicator?.bounds
        var contentViewFrame = self.contentView?.bounds
        
        self.width = Float(indicatorFrame!.size.width) + (2.0 * margin)
        self.height = Float(indicatorFrame!.size.height) + (2.0 * margin)
        
        var contentViewFrameX = floor((Float(frame.size.width) - self.width) / 2 )
        var contentViewFrameY = floor((Float(frame.size.height) - self.height) / 2 )
        
        contentViewFrame = CGRect(x: CGFloat(contentViewFrameX), y: CGFloat(contentViewFrameY), width: CGFloat(self.width), height: CGFloat(self.height))
        
        indicatorFrame?.origin.x = floor(( contentViewFrame!.size.width - indicatorFrame!.size.width ) / 2)
        indicatorFrame?.origin.y = floor(( contentViewFrame!.size.height - indicatorFrame!.size.height ) / 2)
        
        if countElements(labelText) != 0 {
            
            label!.text = self.labelText;
            
            var tempString = NSString(string: self.labelText)
            let dict = [NSFontAttributeName:UIFont.systemFontOfSize(labelFontSize)]
            let size:CGSize = tempString.sizeWithAttributes(dict)
            let stringHeight:Float = Float(size.height)
            var stringWidth:Float = Float(size.width)
            
            if stringWidth > Float(frame.size.width) - 2 * margin {
                stringWidth =  Float(frame.size.width) - 4 * margin;
            }
            
            // 设置装空间view 位置
            if stringWidth > self.width {
                self.width = stringWidth
                contentViewFrameX = floor((Float(frame.size.width) - self.width) / 2 )
                contentViewFrame!.origin.x = CGFloat(contentViewFrameX)
                contentViewFrame!.size.width = CGFloat(self.width)
            }
            
            // 设置 菊花位置
            indicatorFrame?.origin.x = floor(( contentViewFrame!.size.width - indicatorFrame!.size.width ) / 2)
            indicatorFrame?.origin.y = floor(( contentViewFrame!.size.height - indicatorFrame!.size.height ) / 2) - 10
            
            
            // 设置 文字位置
            var labelX:Float = floor((Float(contentViewFrame!.size.width) - stringWidth) / 2)
            var labelY:Float = floor(Float(indicatorFrame!.origin.y) + Float(indicatorFrame!.size.height) + padding * 2)
            var labelFrame = CGRect(x: CGFloat(labelX), y: CGFloat(labelY), width: CGFloat(stringWidth), height: CGFloat(stringHeight))
            
            label?.frame = labelFrame;
        }
        
        
        contentView!.frame = contentViewFrame!
        indicator?.frame = indicatorFrame!
        
        var bgViewFrameX = contentViewFrame!.origin.x - CGFloat(padding)
        var bgViewFrameY = contentViewFrame!.origin.y - CGFloat(padding)
        var bgViewFrameWidth = contentViewFrame!.size.width + CGFloat(padding * 2)
        var bgViewFrameHeight = contentViewFrame!.size.height + CGFloat(padding * 2)
        
        bgView?.frame = CGRect(x: bgViewFrameX, y: bgViewFrameY, width: bgViewFrameWidth, height: bgViewFrameHeight)
        
    }
    
    func show (animation:Bool) {
        if animation == true {
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.contentView!.alpha = 1.0
                self.bgView!.alpha = 0.8
            })
            
        } else {
            self.contentView!.alpha = 1.0
            self.bgView!.alpha = 0.8
        }
    }
    
    func hideAndRemove (animation:Bool) {
        if animation == true {
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.contentView!.alpha = 0.0
                self.bgView!.alpha = 0.0
                }, completion: { (isFinish) -> Void in
                    self.contentView!.removeFromSuperview()
                    self.bgView!.removeFromSuperview()
            })
        } else {
            self.contentView!.alpha = 0.0
            self.bgView!.alpha = 0.0
            
            self.contentView?.removeFromSuperview()
            self.bgView!.removeFromSuperview()
        }
    }
    
    

}
