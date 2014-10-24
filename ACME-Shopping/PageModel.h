//
//  PageModel.h
//  ACME-Shopping
//
//  Created by fady on 13-10-24.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

/*
 "result": 1,
 "pagebeans": [
 {
 "distance": 1,
 "drawline": true,
 "height": 5232,
 "items": [
 {
 "bitmapurl": "http://img.taobaocdn.com/bao/uploaded/http://img03.taobaocdn.com/bao/uploaded/i3/15603025097430172/T1gTBEFkFgXXXXXXXX_!!2-item_pic.png_250x250.jpg",
 "rect": {
 "b": 247,
 "id": -1,
 "l": 0,
 "r": 240,
 "t": 0
 },
 "type": 1,
 "uri": "null,null,17120805219,4,36.80"
 },
 ///////////////////////////////
 */
#import "BaseModel.h"

@interface PageModel : BaseModel

@property(nonatomic, copy)NSString *bitmapurl;
@property(nonatomic, strong)NSDictionary *rect;
@property(nonatomic, strong)NSNumber *type;
@property(nonatomic, copy)NSString *uri;
@property(nonatomic, copy)NSString *itemId;

@end

