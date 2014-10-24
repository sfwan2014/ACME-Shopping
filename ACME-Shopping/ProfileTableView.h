//
//  ProfileTableView.h
//  ACME-Shopping
//
//  Created by fady on 13-11-2.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileTableView : UITableView<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, copy)NSString *username;

@end
