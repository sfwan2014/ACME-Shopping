//
//  HomeViewController.m
//  ACME-Shopping
//
//  Created by fady on 13-10-23.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "HomeViewController.h"
#import "ZZDataServier.h"
#import "IndexTableView.h"
#import "IndexModel.h"
#import "HomeScrollView.h"
#import "PageModel.h"
#import "HomeTableVIew.h"
#import "ItemModel.h"
#import "CustomModel.h"
#import "ASIFormDataRequest.h"
#import "AppModel.h"

@interface HomeViewController ()<HomeScrollViewDelegate>

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    self.isHomeView = YES;
    [super viewDidLoad];
    
    self.title = @"趣购时尚";
    
    pageNum = 2;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"digest.plist" ofType:nil];
    digestDic = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    _pageDic = [[NSMutableDictionary alloc] init];
    
    // 加载滚动视图
    [self _loadScrollView];
    
    // 加载动画
    _scrollView.hidden = YES;
    [self showLoadingInView:self.view];
    
    // 加载索引视图
    [self _initIndexView];
    
    // 加载数据
//    [self _loadIndexData];
    [self _loadLocationData];
    
    [_scrollView addObserver:_indexView forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionNew context:nil];
}

-(NSMutableDictionary *)params:(NSString *)key value:(NSString *)value
{
    /*
     action=getIndex&api_version=1.2.1&client_name=com.taobao.wireless.wht.a180&client_source=android&client_version=1.2.0&digest=2D548FC07DE565DAF8B224879AB223C4&fpoint=00180&imei=869323000391744&imsi=460009151947105&module=pageService&screenW=480&screenY=854&wht_type=taoke
 
     */
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:value forKey:key];

    [params setObject:@"1.2.1" forKey:@"api_version"];
    [params setObject:@"com.taobao.wireless.wht.a180" forKey:@"client_name"];
    [params setObject:@"android" forKey:@"client_source"];
    [params setObject:@"1.2.0" forKey:@"client_version"];
    [params setObject:@"00180" forKey:@"fpoint"];
    
    [params setObject:@"869323000391744" forKey:@"imei"];
    [params setObject:@"460009151947105" forKey:@"imsi"];
    
    [params setObject:@"pageService" forKey:@"module"];
    
    [params setObject:@"320" forKey:@"screenW"];
    [params setObject:@"480" forKey:@"screenY"];
    
    [params setObject:@"wht_type" forKey:@"taoke"];
    
    return params;
}

#pragma mark - loadData

// 加载数据
-(void)_loadIndexData
{
    if (self.request != nil) {
        [self.request cancel];
        self.request = nil;
    }
    
    NSMutableDictionary *params = [self params:@"action" value:@"getIndex"];
    [params setObject:@"2D548FC07DE565DAF8B224879AB223C4" forKey:@"digest"];
    
    __weak HomeViewController *this = self;
    self.request = [ZZDataServier requestWithURL:NULL params:params httpMethod:@"POST" block:^(id result) {
        __strong HomeViewController *strongThis = this;
        [strongThis afterLoadIndexData:result];
    }];
}

-(void)_loadLocationData
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"homeJson.geojson" ofType:nil];
    //    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    NSString *string = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    NSLog(@"%@", error);
    NSDictionary *result = [string JSONValue];
    
    [self afterLoadIndexData:result];
}


-(void)_loadPageData:(HomeTableVIew *)collectionView index:(long)index
{
//    [self _loadNetworkData:collectionView index:index];
    [self _loadLocationPageData];
}

-(void)_loadLocationPageData
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"page.geojson" ofType:nil];
    //    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    NSString *string = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    NSLog(@"%@", error);
    NSDictionary *result = [string JSONValue];
    [self afterLoadPageData:result];
}

-(void)_loadNetworkData:(HomeTableVIew *)collectionView index:(long)index
{
    if (self.request != nil) {
        [self.request cancel];
        self.request = nil;
    }
    
    /*
     action=getPage&digest=F84B45599A7C50AFF8E5685E86BB5782&image_size=375&index=1&nettype=wifi&screenW=480&screenY=854&title=%E9%A5%B0%E5%93%81%E7%8F%A0%E5%AE%9D&wht_type=taoke&width=480
     */
    NSMutableDictionary *params = [self params:@"action" value:@"getPage"];
    
    IndexModel *indexModel = _indexData[index];
    NSString *title = indexModel.title;
    NSString *digest = [digestDic objectForKey:title];
    [params setObject:digest forKey:@"digest"];
    
    [params setObject:@"375" forKey:@"image_size"];
    
    [params setObject:@"1" forKey:@"index"];
    [params setObject:@"wifi" forKey:@"nettype"];
    [params setObject:title forKey:@"title"];
    [params setObject:@"480" forKey:@"width"];
    
    __weak HomeViewController *this = self;
    self.request = [ZZDataServier requestWithURL:NULL params:params httpMethod:@"POST" block:^(id result) {
        __strong HomeViewController *strongThis = this;
        [strongThis afterLoadPageData:result];
        [collectionView doneLoadingTableViewData];
        [collectionView reloadData];
    }];
}

-(void)_loadMoreData:(HomeTableVIew *)collectionView index:(long)index
{
    if (self.request != nil) {
        [self.request cancel];
        self.request = nil;
    }

    NSMutableDictionary *params = [self params:@"action" value:@"getPage"];
    
    IndexModel *indexModel = _indexData[index];
    NSString *title = indexModel.title;
    NSString *digest = [digestDic objectForKey:title];
    [params setObject:digest forKey:@"digest"];
    
    [params setObject:@"375" forKey:@"image_size"];
    NSString *page = [NSString stringWithFormat:@"%d", pageNum];
    
    [params setObject:page forKey:@"index"];
    [params setObject:@"wifi" forKey:@"nettype"];
    [params setObject:title forKey:@"title"];
    [params setObject:@"480" forKey:@"width"];
    
    __weak HomeViewController *this = self;
    self.request = [ZZDataServier requestWithURL:NULL params:params httpMethod:@"POST" block:^(id result) {
        __strong HomeViewController *strongThis = this;
        [strongThis afterLoadMoreData:result];
    }];
}

#pragma mark - after load data
-(void)afterLoadIndexData:(NSDictionary *)result
{
    NSArray *indexArray = [result objectForKey:@"index"];
    _indexData = [[NSMutableArray alloc] initWithCapacity:indexArray.count];
    for (int i = 0; i < indexArray.count; i++) {
        NSDictionary *dic = indexArray[i];
        IndexModel *index = [[IndexModel alloc] initWithDataDic:dic];
        if (i == 0) {
            index.title = @"趣购时尚";
        }
        
        if ([index.title isEqualToString:@"宝贝大全"] || [index.title isEqualToString:@"精品应用"]) {
            continue;
        }
        
        [_indexData addObject:index];
    }
    
    NSArray *customList = [result objectForKey:@"customList"];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in customList) {
        CustomModel *custom = [[CustomModel alloc] initWithDataDic:dic];
        [array addObject:custom];
    }
    
    [_pageDic setObject:_indexData forKey:@"index"];
    
    _indexView.data = _indexData;
    [_indexView reloadData];

    _scrollView.hidden = NO;
    [self hiddenLoding];
    
    _scrollView.indexData = _indexData;
    _scrollView.data = array;
}

-(void)afterLoadPageData:(NSDictionary *)result
{
    NSArray *pagebeans = [result objectForKey:@"pagebeans"];
    
    for (NSDictionary *dic in pagebeans) {
        NSString *title = [dic objectForKey:@"title"];
        NSArray *items = [dic objectForKey:@"items"];
        NSMutableArray *pages = [NSMutableArray arrayWithCapacity:items.count];
        for (int i = 0; i < items.count; i++) {
            NSDictionary *itemDic = items[i];
            PageModel *pageModel = [[PageModel alloc] initWithDataDic:itemDic];
            
            NSArray *uri = [pageModel.uri componentsSeparatedByString:@","];
            
            pageModel.itemId = [uri objectAtIndex:2];
            [pages addObject:pageModel];
        }
        
        self.data = pages;
        
        [_pageDic setObject:pages forKey:title];
    }
    _scrollView.selectedIndex = 7;
    _scrollView.data = _pageDic;
}

-(void)afterLoadMoreData:(NSDictionary *)result
{
    pageNum++;
    NSArray *pagebeans = [result objectForKey:@"pagebeans"];
    
    for (NSDictionary *dic in pagebeans) {
        NSString *title = [dic objectForKey:@"title"];
        NSArray *items = [dic objectForKey:@"items"];
        NSMutableArray *pages = [NSMutableArray arrayWithCapacity:items.count];
        for (int i = 0; i < items.count; i++) {
            NSDictionary *itemDic = items[i];
            PageModel *pageModel = [[PageModel alloc] initWithDataDic:itemDic];
            
            NSArray *uri = [pageModel.uri componentsSeparatedByString:@","];
            
            pageModel.itemId = [uri objectAtIndex:2];
            [pages addObject:pageModel];
        }
        
        if (pages.count > 0) {
            [self.data addObjectsFromArray:pages];
            [_pageDic setObject:self.data forKey:title];
        }
    }
    
    _scrollView.data = _pageDic;
}

// 加载滚动视图
-(void)_loadScrollView
{
    _scrollView = [[HomeScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.homeDelegate = self;
    
    [self.view addSubview:_scrollView];
}

// 加载索引视图
-(void)_initIndexView
{
    _backView = [[UIView alloc] initWithFrame:self.view.bounds];
    _backView.backgroundColor = [UIColor clearColor];
    _backView.left = -kScreenWidth;
    _indexView = [[IndexTableView alloc] initWithFrame:CGRectMake(0, 20, 120, self.view.height - 20-40) style:UITableViewStylePlain];
    _indexView.selectedDelegate = _scrollView;
    
    _indexView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.9];
    [_backView addSubview:_indexView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _indexView.width, 40)];
    UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
    view.backgroundColor = [UIColor grayColor];
    
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor whiteColor];
    label.text = @"目录";
    [view addSubview:label];
    _indexView.tableHeaderView = view;
    _indexView.tableHeaderView.height = view.height;
    
    // 添加点击手势
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(_indexView.right, 0, kScreenWidth-_indexView.width, _backView.height)];
    rightView.backgroundColor = [UIColor clearColor];
    [_backView addSubview:rightView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [rightView addGestureRecognizer:tap];
    
}

#pragma mark - tapAction swipeAction
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    CGRect frame = _backView.frame;
    frame.origin.x = -kScreenWidth;
    [UIView animateWithDuration:0.3 animations:^{
        _backView.frame = frame;
    }];
}

#pragma mark - HomeScrollView delegate
-(void)showIndexView:(HomeScrollView *)scrollView
{
    CGRect frame = _backView.frame;
    frame.origin.x = 0;
    [UIView animateWithDuration:0.3 animations:^{
        _backView.frame = frame;
    }];
}

-(void)loadSubViewData:(HomeTableVIew *)collectionView index:(long)index
{
//    collectionView.hidden = YES;
//    [self showLoadingInView:collectionView];
    if (index != 0) {
        [self _loadPageData:collectionView index:index];
    } else {
//        [self _loadIndexData];
//        [self _loadLocationData];
    }
    
}

-(void)loadSubViewMoreData:(HomeTableVIew *)collectionView index:(long)index
{
    [self _loadMoreData:collectionView index:index];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (_backView.superview == nil) {
        UIWindow *window = [[UIApplication sharedApplication]keyWindow];
        [window addSubview:_backView];
        [window bringSubviewToFront:_backView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
