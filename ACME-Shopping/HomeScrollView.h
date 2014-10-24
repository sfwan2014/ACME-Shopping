//
//  HomeScrollView.h
//  ACME-Shopping
//
//  Created by fady on 13-10-24.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeTableVIew.h"

@class HomeScrollView;
@class HomeTableVIew;
@protocol HomeScrollViewDelegate <NSObject>

@optional
-(void)showIndexView:(HomeScrollView *)scrollView;
-(void)loadSubViewData:(HomeTableVIew *)collectionView index:(long)index;
-(void)loadSubViewMoreData:(HomeTableVIew *)collectionView index:(long)index;

-(void)refreshData:(HomeScrollView *)tableView;

@end

@interface HomeScrollView : UIScrollView<UIScrollViewDelegate, HomeTableVIewDelegate, RefreshDelegate>
{
    NSMutableArray *_tableViews;
}

@property(nonatomic, strong)NSArray *indexData;
@property(nonatomic, strong)NSMutableDictionary *pageData;
@property(nonatomic, strong)id data;

@property(nonatomic, weak) id<HomeScrollViewDelegate>homeDelegate;
@property(nonatomic, assign)int selectedIndex;

@end
