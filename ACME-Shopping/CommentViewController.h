//
//  CommentViewController.h
//  ACME-Shopping
//
//  Created by fady on 13-10-30.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseViewController.h"

@class CommentTableView;
@class DetailModel;
@interface CommentViewController : BaseViewController

@property(nonatomic, strong)DetailModel *model;

@property (weak, nonatomic) IBOutlet CommentTableView *tableView;

@end
