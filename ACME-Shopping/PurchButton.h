//
//  PurchButton.h
//  ACME-Shopping
//
//  Created by fady on 13-10-29.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurchButton : UIControl

-(id)initWithFrame:(CGRect)frame;

@property(nonatomic, strong)NSString *price;
@property(nonatomic, strong)UIFont *textFont;

@end
