//
//  BaseCollectionView.h
//  ACME-Shopping
//
//  Created by fady on 13-10-24.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@class BaseCollectionView;
@protocol RefreshDelegate <NSObject>

@optional
-(void)pullDown:(BaseCollectionView *)tableView;
-(void)pullUp:(BaseCollectionView *)tableView;
@end

@interface BaseCollectionView : UICollectionView<UICollectionViewDataSource, UICollectionViewDelegate, EGORefreshTableHeaderDelegate>
{
    id _data;
    EGORefreshTableHeaderView *_refreshTableHeaderView;
}

@property(nonatomic, strong)id data;
@property(nonatomic, assign)BOOL reloading;
@property(nonatomic, assign)id<RefreshDelegate>pullDelegate;
@property(nonatomic, assign)BOOL isPull;

- (void)doneLoadingTableViewData;

@end
