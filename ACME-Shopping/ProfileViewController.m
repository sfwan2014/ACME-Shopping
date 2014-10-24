//
//  ProfileViewController.m
//  ACME-Shopping
//
//  Created by fady on 13-10-23.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileTableView.h"
#import "LoginViewController.h"
#import "ZZNavigationController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"个人中心";
    
//    self.tableView.username = @"你的土豪金掉了";
    
    [self _loadLoginNoticeButton];
    [self _loadNavagationItem];
}

-(void)_loadNavagationItem
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 25, 25);
    [button setImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"login_pressed.png"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)_loadLoginNoticeButton
{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 0, 300, 40);
    UIImage *image_n =  [UIImage imageNamed:@"login_bg.9.png"];
    image_n = [image_n stretchableImageWithLeftCapWidth:3 topCapHeight:35];
    UIImage *image_h =  [UIImage imageNamed:@"login_bg_press.9.png"];
    image_h = [image_h stretchableImageWithLeftCapWidth:3 topCapHeight:12];
    
    [button setBackgroundImage:image_n forState:UIControlStateNormal];
    [button setBackgroundImage:image_h forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 2013;
    
    [button setTitle:@"亲, 您还没有登录哦" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [self.view addSubview:button];
}

-(void)loginAction:(UIButton *)button
{
    LoginViewController *loginCtrl = [[LoginViewController alloc] init];
    loginCtrl.ishomeButton = NO;
    loginCtrl.finishblock = ^(NSDictionary *userInfo) {
        self.tableView.username = [userInfo objectForKey:@"taobao_user_nick"];
        if (button.tag == 2013) {
            button.hidden = YES;
        }
    };
    [self.navigationController pushViewController:loginCtrl animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
