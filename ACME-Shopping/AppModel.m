//
//  AppModel.m
//  ACME-Shopping
//
//  Created by fady on 13-11-17.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "AppModel.h"

@implementation AppModel

-(void)setAttributes:(NSDictionary*)dataDic{
    [super setAttributes:dataDic];
    
    NSNumber *appId = [dataDic objectForKey:@"id"];
    self.appId = appId;
}

@end
