//
//  ZoomImageView.h
//  ZZWeibo
//
//  Created by ios on 13-10-14.
//  Copyright (c) 2013年 万绍发 邮箱 www.854347546@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDProgressView.h"
#import "MBProgressHUD.h"

@protocol ZoomImageViewDelegate <NSObject>

@optional
-(void)imageWillZoomIn:(UIView *)view;
-(void)imageDidZoomIn:(UIView *)view;

-(void)imageWillZoomOut:(UIView *)view;
-(void)imageDidZoomOut:(UIView *)view;

@end

@class ThemeButton;
@interface ZoomImageView : UIImageView<NSURLConnectionDataDelegate>
{
    UIScrollView *_scrollView;
    UIImageView *_fullImageView;
    DDProgressView *_progressView;
    
    UIButton *_saveButton;
    
    float _length;
    NSMutableData *_data;
    
    MBProgressHUD *_hud;
}

@property(nonatomic, copy) NSString *urlstring;
@property(nonatomic, retain) NSURLConnection *connect;
@property(nonatomic, assign) id<ZoomImageViewDelegate>delegate;

-(void)addZoom:(NSString *)urlstring;

-(void)zoomOutAction;

@end
