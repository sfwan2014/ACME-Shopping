//
//  CommodityView.m
//  ACME-Shopping
//
//  Created by fady on 13-10-25.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "CommodityView.h"
#import "ItemModel.h"
#import "DetailViewController.h"
#import "ListViewController.h"
#import "WebViewController.h"


@implementation CommodityView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initViews];
    }
    return self;
}

-(void)_initViews
{
//    self.userInteractionEnabled = YES;
    
    self.layer.masksToBounds = YES;
    
//    [self addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
//    self.backgroundColor = [UIColor clearColor];
//    imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
//    imageView.userInteractionEnabled = YES;
//    [self addSubview:imageView];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
//    [self addGestureRecognizer:tap];
}

-(void)tapAction
{
    
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.ishomeButton = NO;
    detail.model = self.model;
    [self.viewController.navigationController pushViewController:detail animated:YES];
    
    return;

    if ([self.model isKindOfClass:[ItemModel class]]) {
        ItemModel *model = (ItemModel *)self.model;
        NSString *linktype = model.linktype;
        if ([linktype isEqualToString:@"searchlist"]) {
            NSLog(@"跳转搜索列表");
            ListViewController *listCtrl = [[ListViewController alloc] init];
            listCtrl.model = model;
            [self.viewController.navigationController pushViewController:listCtrl animated:YES];
            
        } else if ([linktype isEqualToString:@"pindao"]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kPinDaoChangeNotification object:model userInfo:Nil];
            NSLog(@"跳转频道");
        } else if ([linktype isEqualToString:@"item"]) {
            DetailViewController *detail = [[DetailViewController alloc] init];
            detail.ishomeButton = NO;
            detail.model = self.model;
            [self.viewController.navigationController pushViewController:detail animated:YES];
            
        } else if ([model.linktype isEqualToString:@"http"]) {
            NSString *urlstring = [model.link objectForKey:@"url"];
//            NSURL *url = [NSURL URLWithString:urlstring];
            WebViewController *webView = [[WebViewController alloc] init];
            webView.url = urlstring;
            [self.viewController.navigationController pushViewController:webView animated:YES];
        }
        
    } else {
        DetailViewController *detail = [[DetailViewController alloc] init];
        detail.ishomeButton = NO;
        detail.model = self.model;
        [self.viewController.navigationController pushViewController:detail animated:YES];
    }
    
}

@end
