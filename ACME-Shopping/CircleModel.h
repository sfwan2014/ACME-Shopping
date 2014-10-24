//
//  CircleModel.h
//  ACME-Shopping
//
//  Created by fady on 13-10-31.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//
/*
 "totalCount": 461,
 "threadList": [{
 "content": "不会买…",
 "createTime": "2013-10-30 15:18:32",
 "favorCount": 0,
 "groupId": 1526001,
 "threadId": 2473399,
 "authorNick": "tb86664995",
 "item": {
         "categoryId": 50012028,
         "deleted": 0,
         "gmtCreate": "2013-10-30 15:18:32",
         "gmtModified": "2013-10-30 15:18:32",
         "groupId": 1526001,
         "id": 0,
         "itemId": 25856748076,
         "picUrl": "http://img02.taobaocdn.com/imgextra/i2/16894036349588433/T1tDphFmNfXXXXXXXX_!!0-item_pic.jpg",
         "price": 12000,
         "replyId": 0,
         "shareContent": "",
         "threadId": 0,
         "title": "2013春秋款女鞋绒面内增高平底靴后系绑带过膝长靴长筒靴高筒靴女"
         },
 "authorPic": "http://download.taobaocdn.com/dipei/group_user_pic.jpg",
 "isMaster": false,
 "replayCount": 0,
 "authorId": 1873005156
 },
 */
#import "BaseModel.h"

@interface CircleModel : BaseModel

@property(nonatomic, strong)NSNumber *favorCount;
@property(nonatomic, strong)NSNumber *groupId;
@property(nonatomic, strong)NSNumber *threadId;
@property(nonatomic, strong)NSNumber *isMaster;
@property(nonatomic, strong)NSNumber *replayCount;
@property(nonatomic, strong)NSNumber *authorId;
@property(nonatomic, strong)NSDictionary *item;

@property(nonatomic, copy)NSString *originalPic;
@property(nonatomic, copy)NSString *content;
@property(nonatomic, copy)NSString *createTime;
@property(nonatomic, copy)NSString *authorNick;
@property(nonatomic, copy)NSString *authorPic;


@end
