//
//  BaseTableView.h
//  ACME-Shopping
//
//  Created by fady on 13-10-23.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableView : UITableView<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)NSArray *data;

@end
