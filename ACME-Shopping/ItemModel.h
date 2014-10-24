//
//  ItemModel.h
//  ACME-Shopping
//
//  Created by fady on 13-10-24.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

/*
 {
 "content":
 {
 "text": "签到暂停"
 },
 
 "image": "http://img1.tbcdn.cn:80/L1/68/5250/c5530e22d52344e4b7a312248ebfba45.png",
 "link": {
 "action": "searchItems",
 "catName": "蕾丝衫/雪纺衫",
 "cid": "162116",
 "discount": "true",
 "key": "雪纺",
 "module": "itemService",
 "templates": "20,22,23"
 },
 "linktype": "searchlist",
 "title": "",
 "type": "item"
 },
 
 
 
 "cid": 0,
 "link":
 {
 "action": "searchItems",
 "catName": "箱包皮具/热销女包/男包",
 "cid": "50006842",
 "key": "手拿包",
 "module": "itemService",
 "templates": "20,22,23"
 },
 
 "linktype": "searchlist",
 "name": "手拿包",
 "nicks": "",
 "title": "手拿包",
 "type": "2"
 },
 
 

 */

#import "BaseModel.h"

@interface ItemModel : BaseModel

@property(nonatomic, strong)NSDictionary *link;
@property(nonatomic, strong)NSNumber *cid;

@property(nonatomic, copy)NSString *linktype;
@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *nicks;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *type;

//
@property(nonatomic, strong)NSDictionary *content;
@property(nonatomic, copy)NSString *image;
@property(nonatomic, copy)NSString *mtype;



@end
