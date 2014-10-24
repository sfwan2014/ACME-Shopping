//
//  DetailModel.h
//  ACME-Shopping
//
//  Created by fady on 13-10-29.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseModel.h"

@interface DetailModel : BaseModel

@property(nonatomic, strong)NSNumber *evaluateCount;// 评价
@property(nonatomic, strong)NSNumber *favoriteCount;// 喜欢
@property(nonatomic, strong)NSNumber *numIid;

@property(nonatomic, strong)NSArray  *itemImgs;     // 图片
@property(nonatomic, strong)NSNumber *volume;       // 销量
@property(nonatomic, copy) NSString *picUrl;
@property(nonatomic, copy) NSString *wapDetailUrl;  //图文详情请
@property(nonatomic, strong)NSNumber *promotionPrice;   // 促销价格
@property(nonatomic, strong)NSNumber *price;            // 价格
@property(nonatomic, copy) NSString *tradeUrl;      // 登录淘宝
@property(nonatomic, copy) NSString *title;     //标题
@property(nonatomic, copy) NSString *shopTitle; //

//"nick": "一叶星旗舰店",

//"numIid": 17721075674,

@property(nonatomic, copy)NSString *nick;
//@property(nonatomic, strong)NSNumber *nu

@end
