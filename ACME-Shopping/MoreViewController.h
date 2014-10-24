//
//  MoreViewController.h
//  ACME-Shopping
//
//  Created by fady on 13-10-23.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseViewController.h"

@interface MoreViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
