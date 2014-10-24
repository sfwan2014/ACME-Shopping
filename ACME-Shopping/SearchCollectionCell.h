//
//  SearchCollectionCell.h
//  ACME-Shopping
//
//  Created by fady on 13-10-30.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseCollectionCell.h"

@class SearchModel;
@class ItemModel;
@interface SearchCollectionCell : BaseCollectionCell

@property(nonatomic, strong)ItemModel *model;
@property(nonatomic, assign)BOOL isDraw;
@property(nonatomic, copy)NSString *text;

@end
