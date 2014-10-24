//
//  WebViewController.h
//  ACME-Shopping
//
//  Created by fady on 13-10-30.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController

@property(nonatomic, copy)NSString *url;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
