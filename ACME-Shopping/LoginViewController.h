//
//  LoginViewController.h
//  ACME-Shopping
//
//  Created by fady on 13-11-2.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^LoginDidFinishBlock)(NSDictionary *userInfo);

@interface LoginViewController : BaseViewController<UIWebViewDelegate>

//@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, copy) LoginDidFinishBlock finishblock;

@end
