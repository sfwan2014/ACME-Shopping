//
//  DetailViewController.h
//  ACME-Shopping
//
//  Created by fady on 13-10-29.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseViewController.h"

@class BaseModel;
@class DetailModel;
@class DetailTableView;
@interface DetailViewController : BaseViewController

@property(nonatomic, strong)BaseModel *model;
@property(nonatomic, strong)DetailModel *detailModel;
@property(nonatomic, copy)NSString *numId;

@property (weak, nonatomic) IBOutlet DetailTableView *tableView;

@end
