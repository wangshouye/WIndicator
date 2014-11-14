//
//  WIndicator.swift
//  indicatorDemo
//
//  Created by wangshouye on 14/11/8.
//  Copyright (c) 2014年 wangshouye. All rights reserved.
//

import UIKit

class WIndicator:UIView {
    
   class func showIndicatorAddedTo(view:UIView, animation:Bool) -> WActivityIndicator {
        var resultView = WActivityIndicator(view: view)
        view.addSubview(resultView)
        
        resultView.show(animation)
        
        return resultView
    }
    
    class func removeIndicatorFrom(view:UIView, animation:Bool) {
        var indicatorView: UIView?
        
        for tempView in view.subviews {
            if (tempView as? WActivityIndicator != nil) {
                indicatorView = tempView as WActivityIndicator
                break
            }
        }
        
        if ( indicatorView != nil ) {
            (indicatorView as WActivityIndicator).hideAndRemove(true)
            indicatorView!.removeFromSuperview()
        }
    }

    
    class func showMsgInView(view: UIView, text:String, timeOut interval:NSTimeInterval) -> WIndicatorText {

        var indicatorTextView = WIndicatorText(view: view, text: text, timeOut: interval)
        view.addSubview(indicatorTextView)
        
        
        return indicatorTextView
    }
    
}









