//
//  HomeTableVIew.h
//  ACME-Shopping
//
//  Created by fady on 13-10-23.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseCollectionView.h"
#import "IndexTableView.h"

@class HomeTableVIew;
@protocol HomeTableVIewDelegate <IndexTableViewDelegate>

@optional;
-(void)scrollViewToNext;

@end

@interface HomeTableVIew : BaseCollectionView<UICollectionViewDelegateFlowLayout>
{
    UIImageView *_headerView;
    NSMutableArray *array2D;
}

@property(nonatomic, assign)BOOL isMore;
@property(nonatomic, weak)id<HomeTableVIewDelegate> swipeDelegate;

@end
