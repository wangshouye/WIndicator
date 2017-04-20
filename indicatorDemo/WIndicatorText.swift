//
//  WIndicatorText.swift
//  indicatorDemo
//
//  Created by wangshouye on 14/11/12.
//  Copyright (c) 2014年 wangshouye. All rights reserved.
//

import UIKit

let TagWIndicatorText       = 99999


class WIndicatorText: UIView {
    
    private let margin:CGFloat                  = 20.0
    
    private let maxWidth:CGFloat                = UIScreen.main.bounds.size.width - 2 * 20

    private let labelFontSize:CGFloat           = 16.0
    
    private var bgView                          = UIView()
    private var label                           = UILabel()
    
    private var labelText: String = ""
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(view:UIView, text:String, timeOut interval:TimeInterval) {
        
        self.init(frame: view.bounds)
        self.backgroundColor = UIColor.clear

        self.labelText = text
        self.tag = TagWIndicatorText
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIDeviceOrientationDidChange, object:nil, queue:OperationQueue.main, using:{notification in
            
            self.frame = self.superview?.bounds ?? CGRect.zero
            self.setNeedsDisplay()
        })
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + interval) {
            //code
            UIView.animate(withDuration: interval, animations: { () -> Void in
                self.alpha = 0.0
            }, completion: { (isFinish ) -> Void in
                self.removeFromSuperview()
            })
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bgView.backgroundColor      = UIColor.black
        bgView.layer.cornerRadius   = 10.0
        bgView.layer.masksToBounds  = true
        
        self.addSubview(bgView)
        
        label.font                      = UIFont.systemFont(ofSize: labelFontSize)
        label.adjustsFontSizeToFitWidth = false
        label.textAlignment             = .center
        label.isOpaque                  = false
        label.backgroundColor           = UIColor.clear
        label.textColor                 = UIColor.white
        label.numberOfLines             = 0
        
        bgView.addSubview(label)
    }
    
    override func layoutSubviews () {
        
        let frame = self.bounds
        let tempString = NSString(string: self.labelText)

        let maxLabelSize = CGSize(width: 200, height: Int.max)
        
        let rect = tempString.boundingRect(with: maxLabelSize,
                                           options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                           attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: labelFontSize)],
                                           context: nil)
        
        let stringWidth     = rect.size.width
        let stringHeight    = rect.size.height

        let bgViewWidth     = stringWidth + 2 * margin
        let bgViewHeight    = stringHeight + 2 * margin
        let bgViewX         = (frame.size.width - bgViewWidth ) / 2
        let bgViewY         = (frame.size.height - bgViewHeight ) / 2
        
        let labelX          = (bgViewWidth - stringWidth)/2
        let labelY          = (bgViewHeight - stringHeight)/2

        bgView.frame        = CGRect(x: bgViewX, y: bgViewY, width: bgViewWidth, height: bgViewHeight)
        label.frame         = CGRect(x: labelX, y: labelY, width: stringWidth, height: stringHeight)
        
        label.text          = labelText
    }
}


















