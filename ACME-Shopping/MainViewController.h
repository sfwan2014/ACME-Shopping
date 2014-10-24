//
//  MainViewController.h
//  ZZUNIQLO
//
//  Created by fady on 13-10-22.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController ()

-(void)showTabbar;
-(void)hiddenTabbar;

@end

@interface MainViewController : UITabBarController
{
    UIImageView *_tabbarView;
    UIImageView *_bgView;
    NSMutableDictionary *_backImageViews;
    UIButton *_lastButton;
}

@end

