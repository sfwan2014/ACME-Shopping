//
//  Common.h
//  WXMovie
//
//  Created by wei.chen on 13-8-28.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#ifndef WXMovie_Common_h
#define WXMovie_Common_h

//获取物理屏幕的尺寸
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

//通过三色值获取颜色对象
#define rgb(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//安全释放
#define WXRelease(obj) [obj release];obj = nil;

////////////////////////////////////////////////////////////////////////
//设置是否调试模式
#define WXDEBUG 1

#if WXDEBUG
#define WXLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define WXLog(xx, ...)  ((void)0)
#endif // #ifdef DEBUG
////////////////////////////////////////////////////////////////////////

#define storeHome       @"storeHome/index/" // 店铺URL

#define APP_ID      @"100564139"
#define APP_KEY     @"450648c0657dfcc82bbd61c0b6745254"


#define kPinDaoChangeNotification @"kPinDaoChangeNotification"


#endif
