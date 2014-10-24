//
//  CircleViewController.m
//  ACME-Shopping
//
//  Created by fady on 13-10-23.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "CircleViewController.h"
#import "CircleModel.h"
#import "CircleTableView.h"
#import "NoteViewController.h"
#import "SendViewController.h"
#import "JSON.h"

@interface CircleViewController ()

@end

@implementation CircleViewController
{
    UIButton *noticeButton;
    UIButton *refreshButton;
}

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
	
    noticeDic = [[NSDictionary alloc] init];
    
    self.title = @"圈子";

    
    [super showLoadingInView:self.view];
    self.tableView.hidden = YES;
    
    [self _loadNavigationItem];
    
    [self refreshAction:refreshButton];
}

-(void)_loadNavigationItem
{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 30, 30);
    [leftButton setImage:[UIImage imageNamed:@"circle_new_post.png"] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"circle_new_post_pressed.png"] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(writeArticleAction:) forControlEvents:UIControlEventTouchUpInside];
    

    refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshButton.frame = CGRectMake(0, 0, 30, 30);
    [refreshButton setImage:[UIImage imageNamed:@"title_btn_refresh.png"] forState:UIControlStateNormal];
    [refreshButton addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:refreshButton];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
    
    noticeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    noticeButton.frame = CGRectMake(177, (44-20)/2, 20, 20);
    
    [noticeButton setImage:[UIImage imageNamed:@"circle_notice.png"] forState:UIControlStateNormal];
    [noticeButton addTarget:self action:@selector(noticeAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.navigationController.navigationBar addSubview:noticeButton];
}

-(void)_loadData
{
    NSMutableDictionary *params = [UIUtils params:@"action" value:@"queryThread"];

    [params setObject:@"4F303069271A140F402B1749F1FDE5A3" forKey:@"digest"];
    [params setObject:@"groupService" forKey:@"module"];
    [params setObject:@"0" forKey:@"newThreadId"];
    [params setObject:@"1" forKey:@"pageIndex"];
    [params setObject:@"50" forKey:@"pageSize"];
    
    __weak CircleViewController *this = self;
    [ZZDataServier requestWithURL:@"" params:params httpMethod:@"POST" block:^(id result) {
        __strong CircleViewController *strong = this;
        [strong afterLoadData:result];
    }];
}

-(void)_loadLocationData
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"CircleList.geojson" ofType:nil];
    //    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    NSString *string = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    NSLog(@"%@", error);
    NSDictionary *result = [string JSONValue];
    
    [self afterLoadData:result];
}

-(void)afterLoadData:(NSDictionary *)result
{
    NSArray *threadList = [result objectForKey:@"threadList"];
    
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:threadList.count];
    for (NSDictionary *dic in threadList) {
        CircleModel *model = [[CircleModel alloc] initWithDataDic:dic];
        [models addObject:model];
    }
    
    [super hiddenLoding];
    self.tableView.hidden = NO;
    [refreshButton setImage:[UIImage imageNamed:@"title_btn_refresh.png"] forState:UIControlStateNormal];
    [refreshButton.layer removeAllAnimations];
    refreshButton.transform = CGAffineTransformIdentity;
    
    self.tableView.data = models;
    [self.tableView reloadData];
    
    noticeDic = [result objectForKey:@"notice"];
}

-(void)_loadNoticeView
{
    // 背景
    UIView *backView = [self.view viewWithTag:2013];
    backView.hidden = NO;
    if (backView == nil) {
        backView = [[UIView alloc] initWithFrame:self.view.bounds];
        backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        backView.tag = 2013;
        
        // 提示视图
        UIImageView *noticeView = [[UIImageView alloc] initWithFrame:CGRectMake((150)/2, 2, kScreenWidth - 150, 150)];
        noticeView.userInteractionEnabled = YES;
        UIImage *image = [UIImage imageNamed:@"login_bg.9.png"];
        image = [image stretchableImageWithLeftCapWidth:3 topCapHeight:35];
        noticeView.image = image;
        
        // 内容label
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth - 150, 150)];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor blackColor];

        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 0;
        NSString *text = [noticeDic objectForKey:@"content"];
        label.text = text;
        // 计算内容高度
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(kScreenWidth-150, 1000)];
        label.height = size.height;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(noticeView.width - 35, label.bottom+10, 25, 25);
        [button setImage:[UIImage imageNamed:@"circle_detail.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        
        [noticeView addSubview:button];
        [noticeView addSubview:label];
        [backView addSubview:noticeView];
        
        [self.view addSubview:backView];
        
        // 添加 点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [backView addGestureRecognizer:tap];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    UIView *backView = [self.view viewWithTag:2013];
    backView.hidden = YES;
    
    noticeButton.hidden = YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [UIView animateWithDuration:0.3 animations:^{
        noticeButton.hidden = NO;
    }];
}

#pragma mark - writeArticleAction
-(void)writeArticleAction:(UIButton *)button
{
    SendViewController *sendCtrl = [[SendViewController alloc] initWithNibName:@"SendViewController" bundle:nil];
    sendCtrl.ishomeButton = NO;
    [self.navigationController pushViewController:sendCtrl animated:YES];
}

-(void)refreshAction:(UIButton *)button
{
    [button setImage:[UIImage imageNamed:@"title_btn_refresh_rotate.png"] forState:UIControlStateNormal];
    button.size = CGSizeMake(30, 30);
    [UIView animateWithDuration:0.7 animations:^{
        [UIView setAnimationRepeatCount:1000];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        button.transform = CGAffineTransformRotate(button.transform, 7 *M_PI);
    }];
    
    [UIView commitAnimations];
//    [self _loadData];
    [self _loadLocationData];
    
}

-(void)noticeAction:(UIButton *)button
{
    [self _loadNoticeView];
}

-(void)tapAction:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:tap.view];
    if(point.x > 75 && point.x < 245 && point.y < 150)
    {
        return;
    }
    
    tap.view.hidden = YES;
}

-(void)buttonAction
{
    NoteViewController *noteCtrl = [[NoteViewController alloc] init];
    noteCtrl.ishomeButton = NO;
    NSDictionary *link = [noticeDic objectForKey:@"link"];
    NSString *threadId = [link objectForKey:@"threadId"];
    NSString *groupId = @"1526001";
    CircleModel *model = [[CircleModel alloc] init];
    model.threadId = [NSNumber numberWithInt:[threadId intValue]];
    model.groupId = [NSNumber numberWithInt:[groupId intValue]];
    noteCtrl.model = model;
    [self.navigationController pushViewController:noteCtrl animated:YES];
}

@end
