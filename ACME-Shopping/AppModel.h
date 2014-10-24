//
//  AppModel.h
//  ACME-Shopping
//
//  Created by fady on 13-11-17.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseModel.h"
/*
 {
 "appName": "com.taobao.wireless.life",
 "appType": 0,
 "appVersion": "1.2.0",
 "clientType": 2,
 "desc": "淘宝零食街是一款一站式零食购买服务平台，包含各地特产，养生零食，怀旧食品等等，新增食友圈子，晒美食、聊心得! ",
 "id": 23,
 "imgUrl": "http://img1.tbcdn.cn:80/L1/68/2157/cca0c0d85f8d4bfca8c1eaca46542831.png",
 "title": "淘宝零食街",
 "toAppName": "all",
 "url": "http://download.tbcache.com/L0/L1mOCcXCtgXXcbrpjX.apk"
 },
 */
@interface AppModel : BaseModel

@property(nonatomic, copy)NSString *appName;
@property(nonatomic, copy)NSString *appVersion;
@property(nonatomic, copy)NSString *desc;
@property(nonatomic, copy)NSString *imgUrl;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *toAppName;
@property(nonatomic, copy)NSString *url;

@property(nonatomic, strong)NSNumber *appType;
@property(nonatomic, strong)NSNumber *clientType;
@property(nonatomic, strong)NSNumber *appId;

@end
