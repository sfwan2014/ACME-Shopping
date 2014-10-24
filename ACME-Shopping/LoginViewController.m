//
//  LoginViewController.m
//  ACME-Shopping
//
//  Created by fady on 13-11-2.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "LoginViewController.h"
#import "NSString+URLEncoding.h"
#import "NSStringEx.h"
#import "JSONKit.h"
#import "TaoBaoLoginView.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = @"登录";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    TaoBaoLoginView *loginView = [[TaoBaoLoginView alloc] initWithFrame:self.view.bounds];
    
    __block LoginViewController *this = self;
    loginView.block = ^(TaoBaoLoginView *view){
        if (view.superview != nil) {
            [view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:3];
            LoginViewController *strong = this;
            [strong didLogin];
        }
    };
    [self.view addSubview:loginView];

}

-(void)didLogin
{
    NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    self.finishblock(userInfo);
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}



@end
