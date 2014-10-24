//
//  ZZAboutViewController.m
//  ACME-Shopping
//
//  Created by shaofa on 14-3-26.
//  Copyright (c) 2014年 wanshaofa. All rights reserved.
//

#import "ZZAboutViewController.h"

@interface ZZAboutViewController ()

@end

@implementation ZZAboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        self.title = @"关于我们";
        self.ishomeButton = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:255/255.0 green:223/255.0 blue:190/255.0 alpha:0.91];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
