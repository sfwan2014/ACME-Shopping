//
//  ShopViewController.m
//  ACME-Shopping
//
//  Created by fady on 13-11-17.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "ShopViewController.h"
#import "DetailModel.h"
#import "ListModel.h"

@interface ShopViewController ()

@end

@implementation ShopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.ishomeButton = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self _loadData];

}

-(void)setModel:(BaseModel *)model
{
    _model = model;
}


-(void)_loadData
{
    NSMutableDictionary *params = [UIUtils params:@"digest" value:@"8286AE4BEE052ABCDE7BDE975243B310"];

    if ([self.model isKindOfClass:[DetailModel class]]) {
        DetailModel *model = (DetailModel *)self.model;
        self.title = model.nick;
        
        [params setObject:@"20" forKey:@"page_size"];
        [params setObject:@"375" forKey:@"image_size"];
        [params setObject:@"volume:desc" forKey:@"order_by"];
        [params setObject:@"searchItems" forKey:@"action"];
        [params setObject:@"1" forKey:@"page_no"];
        
        [params setObject:@"itemService" forKey:@"module"];
        [params setObject:model.nick forKey:@"nicks"];
        [params setObject:[NSString stringWithFormat:@"%@", model.numIid] forKey:@"userId"];
        [params setObject:@"jsgvs" forKey:@"ecode"];
        
        __weak ShopViewController *this = self;
        [ZZDataServier requestWithURL:@"" params:params httpMethod:@"POST" block:^(id result) {
            ShopViewController *thisS = this;
            [thisS afterLoadData:result];
        }];
    }
    
    
}

-(void)afterLoadData:(NSDictionary *)result
{
    NSArray *itemList = [result objectForKey:@"itemList"];
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:itemList.count];
    for (NSDictionary *dic in itemList) {
        ListModel *model = [[ListModel alloc] initWithDataDic:dic];
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
