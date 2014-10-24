//
//  AnimationView.h
//  ACME-Shopping
//
//  Created by fady on 13-10-25.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommodityView.h"

@interface AnimationView : UIImageView

+(id)sharenInstance;

@property(nonatomic, strong)NSTimer *timer;
@property(nonatomic, assign)BOOL isCreate;
@property(nonatomic, strong)NSArray *data;

@end
