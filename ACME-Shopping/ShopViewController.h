//
//  ShopViewController.h
//  ACME-Shopping
//
//  Created by fady on 13-11-17.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseViewController.h"
#import "MoreCollectionView.h"
@class BaseModel;
@interface ShopViewController : BaseViewController

@property(nonatomic, strong)BaseModel *model;
@property (weak, nonatomic) IBOutlet MoreCollectionView *tableView;

@end
