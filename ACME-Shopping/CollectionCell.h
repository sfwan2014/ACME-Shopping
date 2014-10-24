//
//  CollectionCell.h
//  ACME-Shopping
//
//  Created by fady on 13-10-24.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseCollectionCell.h"
#import "AnimationView.h"

@class ItemModel;
@interface CollectionCell : BaseCollectionCell
{
    CommodityView *_imageView;
    UIImageView *_backView;
    UILabel *_priceLabel;
    UILabel *_itemLabel;
    AnimationView *changeView;
}

@property(nonatomic, strong)ItemModel *model;
@property(nonatomic, strong)NSArray *data;
@property(nonatomic, assign)BOOL isEnd;
@property(nonatomic, assign)BOOL isImage;
@property(nonatomic, assign)BOOL isDraw;

@property(nonatomic, copy) NSString *text;

+(CGSize)getContentSize:(ItemModel *)model;

@end
