//
//  IndexTableView.h
//  ACME-Shopping
//
//  Created by fady on 13-10-24.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseTableView.h"

@class IndexTableView;

@protocol IndexTableViewDelegate <NSObject>

-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath tableView:(IndexTableView *)tableView;

@end

@interface IndexTableView : BaseTableView

@property(nonatomic, assign)NSInteger selectedIndex;

@property(nonatomic, weak)id <IndexTableViewDelegate> selectedDelegate;

@end
