WIndicator
==========

模仿MBProgressHUD 结合自己的用途 用swift 编码了一套功能一样的控件, 将这三个文件添加到工程中就可以了
WIndicator.swift、WActivityIndicator.swift、WIndicatorText.swift

用法如下
用法一：
        var indicator = WIndicator.showIndicatorAddedTo(self.view, animation: true)

        dispatch_async(dispatch_get_global_queue(0,0), { () -> Void in
            sleep(3)

            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                WIndicator.removeIndicatorFrom(self.view, animation: true)
            })
        })
        
用法二：
        var indicator = WIndicator.showIndicatorAddedTo(self.view, animation: true)
        indicator.text = "swift比用法一多了一行文字"
        dispatch_async(dispatch_get_global_queue(0,0), { () -> Void in
           sleep(3)
    
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
              WIndicator.removeIndicatorFrom(self.view, animation: true)
            })
        })
用法 三

      var indicator = WIndicator.showMsgInView(self.view, text: "浮动窗口测试", timeOut: 1.5)

