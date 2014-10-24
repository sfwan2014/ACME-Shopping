//
//  ListViewController.h
//  ACME-Shopping
//
//  Created by fady on 13-10-30.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseViewController.h"

@class ItemModel;
@class MoreCollectionView;
@interface ListViewController : BaseViewController
{
    int pageNum;
}

@property(nonatomic, copy)ItemModel *model;

@property(nonatomic, copy)NSString *searchKey;
@property(nonatomic, strong)NSMutableArray *data;
@property(nonatomic, copy)NSString *typeName;

@property (weak, nonatomic) IBOutlet MoreCollectionView *tableView;

@end
