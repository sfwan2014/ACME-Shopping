//
//  SearchCollectionView.h
//  ACME-Shopping
//
//  Created by fady on 13-10-30.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseCollectionView.h"

#define kCellId @"cellId_search"

@interface SearchCollectionView : BaseCollectionView<UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)NSDictionary *data;

@property(nonatomic, strong)NSArray *listNames;

@end
