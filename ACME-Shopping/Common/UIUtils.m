//
//  UIUtils.m
//  WXMovie
//
//  Created by wei.chen on 13-9-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "UIUtils.h"
#import "RegexKitLite.h"
#import "NSString+URLEncoding.h"

@implementation UIUtils

+ (NSDate *)dateFromString:(NSString *)datestring formate:(NSString *)formate {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *local = [NSLocale currentLocale];
    [dateFormatter setLocale:local];
    [dateFormatter setDateFormat:formate];
    NSDate *date = [dateFormatter dateFromString:datestring];
    [dateFormatter release];
    
    return date;
}

+ (NSString *)stringFromDate:(NSDate *)date formate:(NSString *)formate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    NSString *datestring = [dateFormatter stringFromDate:date];
    [dateFormatter release];
    
    return datestring;
}

+ (NSString *)fomateString:(NSString *)datestring {
    NSString *formate = @"E MMM d HH:mm:ss Z yyyy";
    NSDate *createDate = [UIUtils dateFromString:datestring formate:formate];
    
    NSString *text = [UIUtils stringFromDate:createDate formate:@"MM-dd HH:mm"];
    return text;
}

+ (NSString *)stringFromNowDate:(NSString *)createTime
{
    NSDate *date = [UIUtils dateFromString:createTime formate:@"yyyy-MM-dd HH:mm:ss"];
    NSString *datestring = [UIUtils stringFromDate:date formate:@"MM月dd日 HH:mm"];
    
    NSDate *date2 = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *string = [dateFormatter stringFromDate:date2];
    date2 = [dateFormatter dateFromString:string];
    
    NSTimeInterval timeInterval = [date2 timeIntervalSinceDate:date];
    
    double time = timeInterval;
    if (time < 60*60*24*2) {
        if (time > 60*60*24) {
            datestring = [UIUtils stringFromDate:date formate:@"前天HH:mm"];
        } else if(time > 0) {
            datestring = [UIUtils stringFromDate:date formate:@"昨天HH:mm"];
        } else {
            datestring = [UIUtils stringFromDate:date formate:@"HH:mm"];
        }
    }
    
    return datestring;
}

+ (long long)countDirectorySize:(NSString *)directory {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取到目录下面所有的文件名
    NSArray *fileNames = [fileManager subpathsOfDirectoryAtPath:directory error:nil];
    
    long long sum = 0;
    for (NSString *fileName in fileNames) {
        NSString *filePath = [directory stringByAppendingPathComponent:fileName];
        
        NSDictionary *attribute = [fileManager attributesOfItemAtPath:filePath error:nil];
        
        //        NSNumber *filesize = [attribute objectForKey:NSFileSize];
        long long size = [attribute fileSize];
        
        sum += size;
    }
    
    return sum;
}


+ (NSString *)parseSourceText:(NSString *)source {
    NSString *regex = @">\\w+<";
    NSArray *array = [source componentsMatchedByRegex:regex];
    if (array.count > 0) {
        //>新浪微博<
        NSString *s = [array objectAtIndex:0];
        NSRange range;
        range.location = 1;
        range.length = s.length - 2;
        NSString *result = [s substringWithRange:range];
        
        return result;
    }
    
    return nil;
}

+ (NSString *)parseLinkText:(NSString *)text {
    /*
     需要添加超链接的字符串:
     1. @用户
     2. http://www.xxx.com
     3. #话题#
     */
    NSString *regex1 = @"@[\\w]+";  //@用户
    NSString *regex2 = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";  //http://www.baidu.com/链接
    NSString *regex3 = @"#[\\w，,]+#";  //#话题#
    NSString *regex = [NSString stringWithFormat:@"%@|%@|%@",regex1,regex2,regex3];
    
    //微博的内容
    //mutableText = @"转发微博 @张三";
//    NSString *text = _weiboModel.text;
    NSArray *macthArray = [text componentsMatchedByRegex:regex];
    
    //@用户       ---> <a href='user://@用户昵称'>@用户昵称</a>
    //http://    ---> <a href='http://xxx'>http://xxxx</a>
    //#话题#      ---> <a href='topic://话题'>#话题#</a>
    
    for (NSString *linkstring in macthArray) {
        
        //判断字符串是否以@字符开头
        if ([linkstring hasPrefix:@"@"]) { //@用户
            NSString *nickName = linkstring;  //@张三
            
            //截取@字符： @张三 ————> 张三
            nickName = [nickName substringFromIndex:1]; //张三
            
            //中文需要url编码
            NSString *encodeName = [nickName URLEncodedString];
            NSString *replacement = [NSString stringWithFormat:@"<a href='user://%@'>@%@</a>",encodeName,nickName];
            
            //替换字符串，将linkstring替换为replacement
            text = [text stringByReplacingOccurrencesOfString:linkstring withString:replacement];
        }
        else if([linkstring hasPrefix:@"http"]) { //http://url
            NSString *replacement = [NSString stringWithFormat:@"<a href='%@'>%@</a>",linkstring,linkstring];
            text = [text stringByReplacingOccurrencesOfString:linkstring withString:replacement];
            
        } else if([linkstring hasPrefix:@"#"]) { //#话题#
            NSString *topicText = linkstring;
            //中文需要url编码
            NSString *topicEncode = [linkstring URLEncodedString];
            NSString *replacement = [NSString stringWithFormat:@"<a href='topic://%@'>%@</a>",topicEncode,topicText];
            
            text = [text stringByReplacingOccurrencesOfString:linkstring withString:replacement];
        }
        
    }
    
    return text;
}

//+ (void)didSelectLinkWithURL:(NSURL*)url viewController:(UIViewController *)viewCtrl {
//    NSString *urlstring = url.absoluteString;
//    if ([urlstring hasPrefix:@"user"]) {
//        //@用户
//        NSString *host = [url host];
//        //中文url解码
//        NSString *userName = [host URLDecodedString];
//        
//        ProfileViewController *profile = [[ProfileViewController alloc] init];
//        profile.nickName = userName;
//        [viewCtrl.navigationController pushViewController:profile animated:YES];
//        [profile release];
//        
//    } else if([urlstring hasPrefix:@"http"]) {
//        //http
//        //        WXLog(@"url:%@",urlstring);
//        
//        WebViewController *webCtrl = [[WebViewController alloc] initWithUrl:urlstring];
//        [viewCtrl.navigationController pushViewController:webCtrl animated:YES];
//        [webCtrl release];
//    } else if([urlstring hasPrefix:@"topic"]) {
//        //topic
//        NSString *host = [url host];
//        //中文url解码
//        NSString *topicName = [host URLDecodedString];
//        WXLog(@"话题：%@",topicName);
//    }
//}

+(NSMutableDictionary *)params:(NSString *)key value:(NSString *)value
{
    /*
     action=getIndex&api_version=1.2.1&client_name=com.taobao.wireless.wht.a180&client_source=android&client_version=1.2.0&digest=2D548FC07DE565DAF8B224879AB223C4&fpoint=00180&imei=869323000391744&imsi=460009151947105&module=pageService&screenW=480&screenY=854&wht_type=taoke
     
     */
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:value forKey:key];
    
    [params setObject:@"1.2.1" forKey:@"api_version"];
    [params setObject:@"com.taobao.wireless.wht.a180" forKey:@"client_name"];
    [params setObject:@"android" forKey:@"client_source"];
    [params setObject:@"1.2.0" forKey:@"client_version"];
//    [params setObject:@"00180" forKey:@"fpoint"];
    
    [params setObject:@"869323000391744" forKey:@"imei"];
    [params setObject:@"460009151947105" forKey:@"imsi"];
    
//    [params setObject:@"pageService" forKey:@"module"];
    
    [params setObject:@"480" forKey:@"screenW"];
    [params setObject:@"854" forKey:@"screenY"];
    
    [params setObject:@"wht_type" forKey:@"taoke"];
    
    return params;
}

@end
