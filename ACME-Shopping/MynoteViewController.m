//
//  MynoteViewController.m
//  ACME-Shopping
//
//  Created by fady on 13-11-2.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "MynoteViewController.h"
#import "CircleModel.h"
#import "NoteTableView.h"

@interface MynoteViewController ()

@end

@implementation MynoteViewController

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

    [self _loadProfileData];
}

-(void)_loadProfileData
{
    NSMutableDictionary *params = [UIUtils params:@"action" value:@"queryThread"];
    [params setObject:@"B054E134F1979D28AD705A39359EB2FC" forKey:@"digest"];
    [params setObject:@"1858718825" forKey:@"authorId"];
    [params setObject:@"PkXms" forKey:@"ecode"];
    [params setObject:@"1858718825" forKey:@"userId"];
    //toke Tf29e3a8a216ad3e9daaf9ac7f283147b1383633988177
    //sign dbc744626a0e15fc9788fbf32011a527
    [params setObject:@"afdd67341e538672330c2668dd8f66cc" forKey:@"sid"];
    [params setObject:@"groupService" forKey:@"module"];
    [params setObject:@"1" forKey:@"pageIndex"];
    [params setObject:@"50" forKey:@"pageSize"];
    
    __weak MynoteViewController *this = self;
    [ZZDataServier requestWithURL:@"" params:params httpMethod:@"POST" block:^(id result) {
        __strong MynoteViewController *strong = this;
        
        [strong afterLoadProfileData:result];
    }];
}

-(void)afterLoadProfileData:(NSDictionary *)result
{
    NSArray *threadReplyList = [result objectForKey:@"threadList"];
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:threadReplyList.count];
    for (NSDictionary *dic in threadReplyList) {
        CircleModel *model = [[CircleModel alloc] initWithDataDic:dic];
        [models addObject:model];
    }
    
    self.tableView.data = models;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
