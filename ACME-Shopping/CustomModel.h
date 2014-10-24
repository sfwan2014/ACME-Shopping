//
//  CustomModel.h
//  ACME-Shopping
//
//  Created by fady on 13-10-24.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

/*
 {
 "columns": 2,
 "itemcount": 6,
 items[{
 ......
 }]
 "mid": 628,
 "mtype": "infoImage",
 "showtitle": false,
 "title": "图片混排"
 },
 */

#import "BaseModel.h"
#import "ItemModel.h"
@interface CustomModel : BaseModel

@property(nonatomic, strong) NSNumber *columns;
@property(nonatomic, strong) NSNumber *itemcount;
@property(nonatomic, strong) NSNumber *mid;
@property(nonatomic, strong) NSNumber *showtitle;
@property(nonatomic, copy) NSString *mtype;
@property(nonatomic, copy) NSString *title;

@property(nonatomic, strong)NSMutableArray *item;

@end
