//
//  UIUtils.h
//  WXMovie
//
//  Created by wei.chen on 13-9-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIUtils : NSObject

//将字符串格式化为Date对象
+ (NSDate *)dateFromString:(NSString *)datestring formate:(NSString *)formate;
//将日期格式化为NSString对象
+ (NSString *)stringFromDate:(NSDate *)date formate:(NSString *)formate;

+ (NSString *)fomateString:(NSString *)datestring;

+ (NSString *)stringFromNowDate:(NSString *)datestring;

//计算目录下面所有文件的大小
+ (long long)countDirectorySize:(NSString *)directory;

+ (NSString *)parseSourceText:(NSString *)source;

+ (NSString *)parseLinkText:(NSString *)text;
+ (void)didSelectLinkWithURL:(NSURL*)url viewController:(UIViewController *)viewCtrl;

+(NSMutableDictionary *)params:(NSString *)key value:(NSString *)value;

@end
