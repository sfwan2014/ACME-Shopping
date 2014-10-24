//
//  CommodityView.h
//  ACME-Shopping
//
//  Created by fady on 13-10-25.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseModel;
@interface CommodityView : UIImageView
{
    UIImageView *imageView;
}

@property(nonatomic, strong)BaseModel *model;

@end
