//
//  CircleViewController.h
//  ACME-Shopping
//
//  Created by fady on 13-10-23.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseViewController.h"

@class CircleTableView;
@interface CircleViewController : BaseViewController
{
    NSDictionary *noticeDic;
    UIView *animationView;
}


@property (weak, nonatomic) IBOutlet CircleTableView *tableView;

@end
