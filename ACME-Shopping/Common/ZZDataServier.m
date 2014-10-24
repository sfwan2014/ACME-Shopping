//
//  ZZDataServier.m
//  ZZUNIQLO
//
//  Created by fady on 13-10-22.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

//#define BASE_URL @"http://www.456c.net/open/"
//#define BASE_URL @"http://www.456c.net/open/"
#define BASE_URL @"http://app.api.yijia.com/newapps/api/"

#import "ZZDataServier.h"
#import "JSONKit.h"

@implementation ZZDataServier

+(ASIFormDataRequest *)requestWithURL:(NSString *)urlstring
               params:(NSMutableDictionary *)params
           httpMethod:(NSString *)httpMethod
                block:(LoadCompletionBolck)block
{
    NSMutableString *url = [NSMutableString stringWithFormat:@"%@%@", BASE_URL, urlstring];
    if ([urlstring hasPrefix:@"http"]) {
        url = [NSMutableString stringWithFormat:@"%@", urlstring];
    }
    
    NSArray *allKeys = [params allKeys];
    if ([httpMethod isEqualToString:@"GET"]) {
        [url appendString:@"?"];
        if (params != nil) {
            for (int i = 0; i < allKeys.count; i++) {
                NSString *key = allKeys[i];
                id value = [params objectForKey:key];
                
                [url appendFormat:@"%@=%@", key, value];
                
                if (i < allKeys.count - 1) {
                    [url appendString:@"&"];
                }
            }
        }
    }
    
    NSLog(@"%@", url);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    [request setRequestMethod:httpMethod];
    [request setTimeOutSeconds:60];
    
    if ([httpMethod isEqualToString:@"POST"]) {
        NSMutableDictionary *HeaderDic = [NSMutableDictionary dictionary];
        [HeaderDic setObject:@"application/x-www-form-urlencoded" forKey:@"Content-Type"];
        [request setRequestHeaders:HeaderDic];
        
        for (NSString *key in allKeys) {
            id value = [params objectForKey:key];
            
            if ([value isKindOfClass:[NSData class]]) {
                [request addData:value forKey:key];
            } else {
                [request addPostValue:value forKey:key];
            }
        }
    }
    
    ASIFormDataRequest *dataRequest = request;
    [request setCompletionBlock:^{
        NSData *data = dataRequest.responseData;
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSString * text = [[NSString alloc]initWithData:data encoding:enc];
        NSLog(@"%@", text);
        id result = [text JSONValue];
        block(result);
    }];
    
    [request setFailedBlock:^{
        NSError *error = dataRequest.error;
        NSLog(@"%@", error);
    }];
    
    [request startAsynchronous];
    
    return request;
}

@end
