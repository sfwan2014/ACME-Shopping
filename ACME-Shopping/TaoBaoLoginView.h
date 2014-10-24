//
//  TaoBaoLoginView.h
//  TaoBaoDemo
//
//  Created by shaofa on 14-2-11.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TaoBaoLoginView;
typedef void(^LoginFinishBlock) (TaoBaoLoginView *loginView);

@interface TaoBaoLoginView : UIView<UIWebViewDelegate>

@property(nonatomic, copy)LoginFinishBlock block;

@end
