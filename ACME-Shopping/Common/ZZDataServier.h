//
//  ZZDataServier.h
//  ZZUNIQLO
//
//  Created by fady on 13-10-22.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
typedef void (^LoadCompletionBolck)(id result);

@interface ZZDataServier : NSObject

//@property(nonatomic, copy)LoadCompletionBolck loadCompletionBlock;

+(ASIFormDataRequest *)requestWithURL:(NSString *)urlstring params:(NSMutableDictionary *)params httpMethod:(NSString *)httpMethod block:(LoadCompletionBolck)block;

@end
