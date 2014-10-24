//
//  CommentModel.h
//  ACME-Shopping
//
//  Created by fady on 13-10-30.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

/*
 "traderateList": [{
 "buyerScore": 0,
 "content": "在图片上看感觉挺厚的，收到货之后有点失望挺薄的，但手感很不错很软，只穿了一上午就起球了，而且很容易挂丝。",
 "created": "2013-10-30 10:34:46",
 "itemPrice": "158.0",
 "itemTitle": "歌慕妮2013新款女装针织开衫女秋薄外套韩版修身针织衫中长款毛衣",
 "nick": "s******y",
 "oid": 444740562991299,
 "ratedNick": "歌慕妮旗舰店",
 "reply": "",
 "result": "good",
 "role": "buyer",
 "tid": 444740562991299,
 "validScore": true
 },
 */

#import "BaseModel.h"

@interface CommentModel : BaseModel

@property(nonatomic, strong)NSNumber *buyerScore;
@property(nonatomic, strong)NSNumber *oid;
@property(nonatomic, strong)NSNumber *tid;
@property(nonatomic, strong)NSNumber *validScore;

@property(nonatomic, copy)NSString *content;
@property(nonatomic, copy)NSString *created;
@property(nonatomic, copy)NSString *itemPrice;
@property(nonatomic, copy)NSString *itemTitle;
@property(nonatomic, copy)NSString *nick;
@property(nonatomic, copy)NSString *ratedNick;
@property(nonatomic, copy)NSString *reply;
@property(nonatomic, copy)NSString *role;
@property(nonatomic, copy)NSString *result;

@end
