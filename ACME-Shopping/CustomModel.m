//
//  CustomModel.m
//  ACME-Shopping
//
//  Created by fady on 13-10-24.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "CustomModel.h"

@implementation CustomModel

-(void)setAttributes:(NSDictionary*)dataDic{
    [super setAttributes:dataDic];
    NSArray *itemArray = [dataDic objectForKey:@"items"];
    NSString *mtype = [dataDic objectForKey:@"mtype"];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:itemArray.count];
    for (NSDictionary *dic in itemArray) {
        ItemModel *item = [[ItemModel alloc] initWithDataDic:dic];
        item.mtype = mtype;
        [array addObject:item];
    }
    
    self.item = array;
}

@end
