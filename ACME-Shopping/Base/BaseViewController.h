//
//  BaseViewController.h
//  ZZUNIQLO
//
//  Created by fady on 13-10-22.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController ()

-(void)showLoadingInView:(UIView *)view;
-(void)hiddenLoding;

@end

@interface BaseViewController : UIViewController
{
    UIView *_backgroundView;
    NSMutableArray *images;
    int time;
}

@property(nonatomic, assign)BOOL isModelButton;
@property(nonatomic, assign)BOOL isHomeView;
@property(nonatomic, assign)BOOL ishomeButton;
@property(nonatomic, strong)NSTimer *timer;

@end
