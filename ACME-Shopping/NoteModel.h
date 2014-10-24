//
//  NoteModel.h
//  ACME-Shopping
//
//  Created by fady on 13-11-1.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

/*
 {
 "content": "好,到了",
 "createTime": "2013-10-31 23:36:04",
 "floor": 87,
 "threadId": 2424030,
 "replyUserId": 260510608,
 "isMaster": false,
 "replyUserPic": "http://img02.taobaocdn.com/imgextra/i2/T17z0_XlNGXXb1upjX.jpg",
 "replyId": 2836954,
 "replyUserNick": "yonghe826"
 },
 */
#import "BaseModel.h"

@interface NoteModel : BaseModel

@property(nonatomic, copy)NSString *content;
@property(nonatomic, copy)NSString *createTime;
@property(nonatomic, copy)NSString *replyUserPic;
@property(nonatomic, copy)NSString *replyUserNick;

@property(nonatomic, strong)NSNumber *floor;
@property(nonatomic, strong)NSNumber *threadId;
@property(nonatomic, strong)NSNumber *replyUserId;
@property(nonatomic, strong)NSNumber *isMaster;
@property(nonatomic, strong)NSNumber *replyId;
@property(nonatomic, strong)NSNumber *item;

@end
