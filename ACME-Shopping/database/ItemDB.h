//
//  ItemDB.h
//  ACME-Shopping
//
//  Created by fady on 13-11-3.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EGODatabase.h"
typedef void (^FindCompletionBlock) (NSArray *result);

@class DetailModel;
@interface ItemDB : NSObject

+(ItemDB *)shareDB;

-(void)addItem:(DetailModel *)model;

-(void)deleteItem:(NSString *)itemId;

-(void)findItems:(FindCompletionBlock)block;

-(DetailModel *)findItem:(NSNumber *)itemId;

@end
