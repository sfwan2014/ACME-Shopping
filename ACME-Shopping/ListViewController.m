//
//  ListViewController.m
//  ACME-Shopping
//
//  Created by fady on 13-10-30.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "ListViewController.h"
#import "MoreCollectionView.h"
#import "SearchModel.h"
#import "ListModel.h"
#import "ItemModel.h"
#import "NSString+URLEncoding.h"


@interface ListViewController ()<RefreshDelegate>

@end

@implementation ListViewController

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
    
    pageNum = 2;
    
    self.tableView.pullDelegate = self;
    
    self.navigationController.navigationBar.hidden = NO;
}

-(void)setModel:(ItemModel *)model
{
    _model = model;
    
    [self _loadTaobaoData];
}

-(void)setSearchKey:(NSString *)searchKey
{
    _searchKey = searchKey;
    
//    [self _loadData];
    [self _loadTaobaoData];
}

-(void)_loadTaobaoData
{
    /*
     http://app.api.yijia.com/newapps/api/tmall_api.php?keyword=%E8%BF%9E%E8%A1%A3%E8%A3%99&page=1
     */
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSString *keyword = nil;
    if (self.searchKey.length > 0) {
        keyword = [self.searchKey URLEncodedString];
    } else {
        NSString *key = [NSString stringWithFormat:@"%@/%@", _typeName, _model.link[@"catName"] ];
        keyword = [key URLEncodedString];
    }
    
    [params setObject:keyword forKey:@"keyword"];
    [params setObject:@"1" forKey:@"page"];
//    [params setObject:@"1" forKey:@"pageIndex"];
//    [params setObject:@"0" forKey:@"sortType"];
//    [params setObject:@"0.00" forKey:@"a_price"];
//    [params setObject:@"0.00" forKey:@"b_price"];
//    [params setObject:@"1" forKey:@"isOnlyMall"];
//    [params setObject:@"0" forKey:@"isCoupon"];
//    [params setObject:@"0" forKey:@"cID"];
//    [params setObject:@"0" forKey:@"StartCouponRate"];
//    [params setObject:@"0" forKey:@"EndCouponRate"];
    
    __weak ListViewController *this = self;
    [ZZDataServier requestWithURL:@"tmall_api.php" params:params httpMethod:@"GET" block:^(id result) {
        ListViewController *thisS = this;
        [thisS afterLoadData:result];
    }];
}


-(void)_loadMoreData
{
    NSDictionary *link = _model.link;
    
    NSMutableDictionary *params = [UIUtils params:@"digest" value:@"8286AE4BEE052ABCDE7BDE975243B310"];
    [params addEntriesFromDictionary:link];
    
    if (self.searchKey != nil) {
        [params setObject:self.searchKey forKey:@"key"];
        [params setObject:@"searchItems" forKey:@"action"];
        [params setObject:@"itemService" forKey:@"module"];
    }
    
    NSString *page = [NSString stringWithFormat:@"%d", pageNum];
    [params setObject:page forKey:@"page_no"];
    
    [params setObject:@"20" forKey:@"page_size"];
    [params setObject:@"375" forKey:@"image_size"];
    [params setObject:@"volume:desc" forKey:@"order_by"];
    
    __weak ListViewController *this = self;
    [ZZDataServier requestWithURL:@"" params:params httpMethod:@"POST" block:^(id result) {
        __strong ListViewController *thisS = this;
        [thisS afterLoadMoreData:result];
    }];
}

-(void)afterLoadData:(NSDictionary *)result
{
    NSArray *itemList = [result objectForKey:@"list"];
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:itemList.count];
    for (NSDictionary *dic in itemList) {
        ListModel *model = [[ListModel alloc] initWithDataDic:dic];
        [models addObject:model];
    }
    self.data = models;
    [self.tableView doneLoadingTableViewData];
    self.tableView.data = models;
    [self.tableView reloadData];
}

-(void)afterLoadMoreData:(NSDictionary *)result
{
    NSArray *itemList = [result objectForKey:@"itemList"];
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:itemList.count];
    for (NSDictionary *dic in itemList) {
        ListModel *model = [[ListModel alloc] initWithDataDic:dic];
        [models addObject:model];
    }
    
    if (models.count > 0) {
        pageNum++;
        [self.data addObjectsFromArray:models];
        self.tableView.data = self.data;
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)pullDown:(BaseCollectionView *)tableView
{

}

-(void)pullUp:(BaseCollectionView *)tableView
{
    [self _loadMoreData];
}

@end
