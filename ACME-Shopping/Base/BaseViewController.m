//
//  BaseViewController.m
//  ZZUNIQLO
//
//  Created by fady on 13-10-22.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseViewController.h"
#import "MoreCollectionView.h"
#import "HomeTableVIew.h"
#import "HomeViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.ishomeButton = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [self setHidesBottomBarWhenPushed:YES];
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    // 设置改视图在父视图上的延伸方向
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    int count = self.navigationController.viewControllers.count;
    
    if (count > 1 ||self.isModelButton) {
        
        [self _loadBackButton];
    }
    
}

-(void)_loadBackButton
{
    self.navigationItem.hidesBackButton = YES;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 35, 35);
    [button setImage:[UIImage imageNamed:@"back_icon.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"back_icon_select.png"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(backAction) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    if (self.ishomeButton) {
        UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        homeButton.frame = CGRectMake(0, 0, 35, 35);
        [homeButton setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
        [homeButton setImage:[UIImage imageNamed:@"home_pressed.png"] forState:UIControlStateHighlighted];
        [homeButton addTarget:self action:@selector(homeAction) forControlEvents: UIControlEventTouchUpInside];
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:homeButton];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)showLoadingInView:(UIView *)view
{
    _backgroundView.hidden = NO;
    
    if (_backgroundView == nil) {
        
        _backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
        _backgroundView.backgroundColor = [UIColor clearColor];
        
        images = [[NSMutableArray alloc] initWithCapacity:4];
        for (int i = 1; i < 5; i++) {
            NSString *imgName = [NSString stringWithFormat:@"animation_%d.png", i];
            UIImage *image = [UIImage imageNamed:imgName];
            [images addObject:image];
        }
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        imageView.tag = 2013;
        imageView.image = images[0];
        [_backgroundView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.text = @"加载中...";
        label.tag = 2014;
        label.backgroundColor = [UIColor clearColor];
        [_backgroundView addSubview:label];
        
        label.center = _backgroundView.center;
        imageView.center = _backgroundView.center;
        label.top = imageView.bottom + 5;
    }
    
    if ([view isKindOfClass:[MoreCollectionView class]] || !self.isHomeView) {
        
        UIImageView *imageView = (UIImageView *)[_backgroundView viewWithTag:2013];
        UILabel *label = (UILabel *)[_backgroundView viewWithTag:2014];
        
        imageView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2-70);
        label.top = imageView.bottom + 5;
        
    }
    
    if (_backgroundView.superview == nil) {
        [view insertSubview:_backgroundView belowSubview:view];
    }

    if (self.timer != nil) {
        return;
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
}

-(void)timeAction:(NSTimer *)timer
{
    if (time > 50) {// 20s
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请求超时" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [self hiddenLoding];
    }
    
    UIImageView *imageView = (UIImageView *)[_backgroundView viewWithTag:2013];
    imageView.image = images[time % 4];
    time++;
}

-(void)hiddenLoding
{
    time = 0;
    [self.timer invalidate];
    self.timer = nil;
    _backgroundView.hidden = YES;
    [_backgroundView removeFromSuperview];
}

-(void)backAction
{
    if (self.isModelButton) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)homeAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
