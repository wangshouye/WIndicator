//
//  ViewController.swift
//  indicatorDemo
//
//  Created by wangshouye on 14/11/8.
//  Copyright (c) 2014年 wangshouye. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

//        用法 一
//        let indicator = WIndicator.showIndicatorAddedTo(self.view, animation: true)
//        indicator.title = "swift 变态啊，好繁琐  不会啊啊啊啊啊啊啊啊啊"
//
//        dispatch_async(dispatch_get_global_queue(0,0), { () -> Void in
//            sleep(3)
//            
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                WIndicator.removeIndicatorFrom(self.view, animation: true)
//            })
//        })

//        用法 二
//        WIndicator.showIndicatorAddedTo(self.view, animation: true)
//
//        dispatch_async(dispatch_get_global_queue(0,0), { () -> Void in
//            sleep(3)
//
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                WIndicator.removeIndicatorFrom(self.view, animation: true)
//            })
//        })

//        用法 三
        WIndicator.showMsgInView(self.view, text: "浮动窗口测试啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊", timeOut: 1.5)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

