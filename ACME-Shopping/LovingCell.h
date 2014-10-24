//
//  LovingCell.h
//  ACME-Shopping
//
//  Created by fady on 13-11-2.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseCollectionCell.h"

@class LovingCell;
@protocol LovingCellDelegate <NSObject>

-(void)deleteFinish:(LovingCell *)cell;

@end

@class DetailModel;
@interface LovingCell : BaseCollectionCell

@property(nonatomic, strong)DetailModel *model;
@property(nonatomic, weak)id<LovingCellDelegate>deleteDelegate;
@property(nonatomic, assign)BOOL isDelete;
@property(nonatomic, strong)UIImageView *imgView;

@end
