//
//  MoreCollectionView.h
//  ACME-Shopping
//
//  Created by fady on 13-10-25.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseCollectionView.h"
#import "RFQuiltLayout.h"

@interface MoreCollectionView : BaseCollectionView<RFQuiltLayoutDelegate>
{
    NSMutableArray *array2D;
}
//@property(nonatomic, strong)NSDictionary *data;

@end
