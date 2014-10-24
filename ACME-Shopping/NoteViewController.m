//
//  NoteViewController.m
//  ACME-Shopping
//
//  Created by fady on 13-11-1.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "NoteViewController.h"
#import "NoteModel.h"
#import "ReplyTableView.h"
#import "SendView.h"
#import "JSON.h"
#import "CircleModel.h"

@interface NoteViewController ()<SendReplyDelegate>

@end

@implementation NoteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.pageIndex = 1;
    [super showLoadingInView:self.view];
    self.tableView.hidden = YES;
    
//    [self _loadCircleData];
    [self _loadLocationData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardAction:) name:UIKeyboardWillChangeFrameNotification object:Nil];
    [self _loadSendView];
}

-(void)_loadCircleData
{
    NSMutableDictionary *params = [UIUtils params:@"action" value:@"queryThreadReply"];
    [params setObject:@"D91752B46040CC710C6BECB49D9708B2" forKey:@"digest"];
    NSString *groupId = [self.model.groupId stringValue];
    [params setObject:groupId forKey:@"groupId"];
    [params setObject:@"groupService" forKey:@"module"];
    [params setObject:[NSString stringWithFormat:@"%d", self.pageIndex] forKey:@"pageIndex"];
    [params setObject:@"50" forKey:@"pageSize"];
    
    NSString *threadId = [self.model.threadId stringValue];
    [params setObject:threadId forKey:@"threadId"];
    
    __weak NoteViewController *this = self;
    [ZZDataServier requestWithURL:@"" params:params httpMethod:@"POST" block:^(id result) {
        __strong NoteViewController *strong = this;
        
        [strong afterLoadCircleData:result];
    }];
}

-(void)_loadLocationData
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Comments.geojson" ofType:nil];
    //    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    NSString *string = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    NSLog(@"%@", error);
    NSDictionary *result = [string JSONValue];
    
    [self afterLoadCircleData:result];
}


-(void)_sendRelpay:(NSString *)text
{
    NSMutableDictionary *params = [UIUtils params:@"action" value:@"publishReply"];
    [params setObject:text forKey:@"content"];
    [params setObject:@"A2164395F225D460FFBC4622DEA6B924" forKey:@"digest"];
    [params setObject:@"bREGq" forKey:@"ecode"];
    [params setObject:@"1526001" forKey:@"groupId"];
    [params setObject:@"groupService" forKey:@"module"];
    [params setObject:@"afdd67341e538672330c2668dd8f66cc" forKey:@"sid"];
    
    NSString *threadId = [self.model.threadId stringValue];
    [params setObject:threadId forKey:@"threadId"];
    [params setObject:@"1858718825" forKey:@"userId"];
    
    __weak NoteViewController *this = self;
    [ZZDataServier requestWithURL:@"" params:params httpMethod:@"POST" block:^(id result) {
        __strong NoteViewController *strong = this;
        [strong _loadCircleData];
    }];
}

-(void)afterLoadCircleData:(NSDictionary *)result
{
    NSDictionary *thread = [result objectForKey:@"thread"];
    
    NSArray *threadReplyList = [result objectForKey:@"threadReplyList"];
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:threadReplyList.count];
    for (NSDictionary *dic in threadReplyList) {
        NoteModel *model = [[NoteModel alloc] initWithDataDic:dic];
        [models addObject:model];
    }
    
    if (thread != nil) {
        self.tableView.thread = thread;
    }
    [super hiddenLoding];
    self.tableView.hidden = NO;
    
    self.tableView.data = models;
    [self.tableView reloadData];
}

-(void)_loadSendView
{
    sendView = [[[NSBundle mainBundle] loadNibNamed:@"SendView" owner:Nil options:Nil] lastObject];
    sendView.frame = CGRectMake(0, self.view.height+44, kScreenWidth, 44);
    sendView.sendDelegate = self;
    [self.view addSubview:sendView];
}

-(void)keyBoardAction:(NSNotification *)notification
{
    __block CGRect frame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:0.3 animations:^{
        sendView.bottom = frame.origin.y - 64;
    }];
}

#pragma mark - sendDelegate
-(void)sendReplay:(NSString *)text
{
    [self _sendRelpay:text];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end



















