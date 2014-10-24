//
//  LovingCollectionView.h
//  ACME-Shopping
//
//  Created by fady on 13-11-2.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "LovingCell.h"
@class DetailModel;
@class LovingCollectionView;

typedef void(^DeleteCompletionBlock) (LovingCollectionView *tableView);
typedef void(^SelectedCompletionBlock) (UIImage *image, DetailModel *model);

@interface LovingCollectionView : UICollectionView<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, LovingCellDelegate>

@property(nonatomic, strong)NSArray *data;
@property(nonatomic, copy)DeleteCompletionBlock block;
@property(nonatomic, copy)SelectedCompletionBlock selectedBlock;


@property(nonatomic, assign)BOOL isDelete;

@end
