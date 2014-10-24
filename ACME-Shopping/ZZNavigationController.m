//
//  ZZNavigationController.m
//  ZZUNIQLO
//
//  Created by fady on 13-10-22.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "ZZNavigationController.h"
#import "MainViewController.h"

@interface ZZNavigationController ()<UINavigationControllerDelegate>

@end

@implementation ZZNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 修改导航栏标题字体
    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:17], UITextAttributeFont,[UIColor whiteColor], UITextAttributeTextColor, nil];
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"title_nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main_bg.jpg"]];

    self.navigationBar.translucent = YES;
    self.delegate = self;
}


#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    int count = navigationController.viewControllers.count;
    if (count == 1) {
        [self.tabBarController showTabbar];
    } else if (count > 1) {
        [self.tabBarController hiddenTabbar];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
