//
//  IndexModel.h
//  ACME-Shopping
//
//  Created by fady on 13-10-24.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//
/*
 "index": [{
 "link": {
 "action": "getOperatePage",
 "fpoint": "00180",
 "module": "pageService",
 "pageid": "oper_home",
 "title": ""
 },
 "linktype": "oper_home",
 "pagestotal": 1,
 "title": ""
 },
 */
#import "BaseModel.h"

@interface IndexModel : BaseModel

@property(nonatomic, strong)NSDictionary *link;
@property(nonatomic, copy) NSString *linktype;
@property(nonatomic, strong)NSNumber *pagestotal;
@property(nonatomic, copy) NSString *title;

@end
