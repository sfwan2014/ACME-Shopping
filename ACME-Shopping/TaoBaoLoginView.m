//
//  TaoBaoLoginView.m
//  TaoBaoDemo
//
//  Created by shaofa on 14-2-11.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import "TaoBaoLoginView.h"
#import "NSString+URLEncoding.h"

#define App_Key         @"21733490"
#define App_Secret      @"fcd1e8ab2c87cdcf80e7cdd7222db12a"
#define Redirect_URI    @"www.oauth.net/2/"

@implementation TaoBaoLoginView
{
    UIWebView *_webView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self _initView];
    }
    return self;
}

-(void)_initView
{
    _webView = [[UIWebView alloc] initWithFrame:self.bounds];
    _webView.scalesPageToFit = YES;
    _webView.delegate = self;
    NSString *urlstring = [NSString stringWithFormat:@"https://oauth.taobao.com/authorize?client_id=%@&response_type=token&redirect_uri=%@state=1212", App_Key, Redirect_URI];
    
    NSLog(@"-----------------------------------%@", urlstring);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    [_webView loadRequest:request];
    
    [self addSubview:_webView];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = request.URL;
    NSString *absoluteString = url.absoluteString;
    NSLog(@"%@", absoluteString);
    
    NSRange range = [absoluteString rangeOfString:@"state=1212#"];
    if (range.location != NSNotFound) {
        range.location += 11;
        range.length = absoluteString.length - range.location;
        NSString *userInfo = [absoluteString substringWithRange:range];
        
        NSLog(@"%@", userInfo);
        
        [self praserUserInfo:userInfo];
        
        return NO;
    }
    
    return YES;
}

-(void)praserUserInfo:(NSString *)userInfo
{
    NSArray *array = [userInfo componentsSeparatedByString:@"&"];
    NSLog(@"%@", array);
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithCapacity:array.count];
    for (NSString *string in array) {
        NSArray *arr = [string componentsSeparatedByString:@"="];
        NSString *value = [arr[1] URLDecodedString];
        [userDic setObject:value forKey:arr[0]];
    }
    
    NSLog(@"%@", userDic);
    if (userDic != nil) {
        [[NSUserDefaults standardUserDefaults] setObject:userDic forKey:@"userInfo"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if (self.block != nil) {
            self.block(self);
        }
    }
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"newslist.js" ofType:nil];
    // 如果jsString 为nil， 说明newslist.js 文件不在 Build Phases --> Copy Bundle Resources中， 需要手动添加进去
    NSString *jsString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"var script = document.createElement('script');"
      "script.type = 'text/javascript';"
    "script.text = %@", jsString]];
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"self.onload()"]];
}

@end
