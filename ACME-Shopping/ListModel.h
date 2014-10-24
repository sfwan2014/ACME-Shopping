//
//  ListModel.h
//  ACME-Shopping
//
//  Created by fady on 13-10-30.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//
/*
 {"total":3495,"list":[
 {"detail_url":"http://www.456c.net/open/gotoBuy.aspx?NumIid=35589087493",
 "num_iid":"35589087493",
 "title":"【湖南馆】银城湘味QQ鱼16g*40袋香辣小鱼仔毛毛鱼干产东江鱼鱼仔",
 "nick":"湖南供销食品专营店",
 "cid":"",
 "pic_url":"http://img01.taobaocdn.com/bao/uploaded/i1/18580029476282198/T1_vD7Fl8bXXXXXXXX_!!0-item_pic.jpg",
 "num":"4350",
 "location":"",
 "price":40,
 "freight":"",
 "auction_price":0,
 "item_imgs":[],
 "prop_imgs":[],"is_lightning_consignment":false,"Seller_credit_score":0,"Coupon_price":0,
 "Coupon_rate":"",
 "Coupon_start_time":"",
 "Coupon_end_time":""
 },
 
 
 {
 "num_iid":"14782522188",
 "pic_url":"http:\/\/gi4.mlist.alicdn.com\/bao\/uploaded\/i4\/T13bZcFv8XXXXXXXXX_!!0-item_pic.jpg_200x200.jpg",
 "title":"\u9177\u5973\u574a 2014\u6625\u88c5\u65b0\u6b3e\u6b27\u7f8e\u725b\u4ed4\u9a6c\u7532\u5973 \u7834\u6d1e\u9a6c\u5939\u80cc\u5fc3\u65e0\u8896\u5916\u5957\u52a0\u5927\u7801",
 "origin_price":"153.00",
 "now_price":"93.00",
 "deal_num":"1225",
 "shop_id":"70950076",
 "post_fee":"0.00",
 "discount":"6.1"
 },
 
 */
#import "BaseModel.h"

@interface ListModel : BaseModel

@property(nonatomic, strong)NSNumber *num_iid;
@property(nonatomic, copy)NSString *detail_url;
@property(nonatomic, copy)NSString *pic_url;
@property(nonatomic, copy)NSString *price;

@end
