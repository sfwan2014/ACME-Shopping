//
//  CommentViewController.m
//  ACME-Shopping
//
//  Created by fady on 13-10-30.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentModel.h"
#import "CommentTableView.h"
#import "DetailModel.h"

@interface CommentViewController ()

@end

@implementation CommentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.ishomeButton = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super showLoadingInView:self.view];
    self.tableView.hidden = YES;
    
//    [self _loadData];
    
    [self _loadLocationData];
}

-(void)_loadLocationData
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Comment.geojson" ofType:nil];
    //    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    NSString *string = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    NSLog(@"%@", error);
    NSDictionary *result = [string JSONValue];
    [self afterLoadData:result];
}

-(void)_loadData
{
    NSMutableDictionary *params = [UIUtils params:@"action" value:@"getTraderateList"];
    [params setObject:@"8B9451E3741C9D8ED3397128C0908806" forKey:@"digest"];
    
    
    [params setObject:_model.shopTitle forKey:@"nick"];
    
    [params setObject:[_model.numIid stringValue] forKey:@"num_iid"];
    
    [params setObject:@"itemService" forKey:@"module"];
    [params setObject:@"1" forKey:@"page_no"];
    [params setObject:@"40" forKey:@"page_size"];
    
    __weak CommentViewController *this = self;
    [ZZDataServier requestWithURL:@"" params:params httpMethod:@"POST" block:^(id result) {
        CommentViewController *thisS = this;
        [thisS afterLoadData:result];
    }];
}

-(void)afterLoadData:(NSDictionary *)result
{
    NSArray *traderateList = [result objectForKey:@"traderateList"];
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:traderateList.count];
    for (NSDictionary *dic in traderateList) {
        CommentModel *model = [[CommentModel alloc] initWithDataDic:dic];
        [models addObject:model];
    }
    
    if (models.count == 0) {
        self.tableView.hidden = YES;
        
    }
    
    [super hiddenLoding];
    self.tableView.hidden = NO;
    
    self.tableView.data = models;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
