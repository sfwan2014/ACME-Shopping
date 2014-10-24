//
//  MoreCollectionCell.h
//  ACME-Shopping
//
//  Created by fady on 13-10-25.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseCollectionCell.h"
#import "PageModel.h"
#import "CommodityView.h"
@interface MoreCollectionCell : BaseCollectionCell
{
    CommodityView *_imageView;
    UIImageView *_backView;
    UILabel *_priceLabel;
}

@property(nonatomic, strong)BaseModel *model;
+(CGSize)getContentSize:(PageModel *)model;

@end
