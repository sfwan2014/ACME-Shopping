//
//  HomeScrollView.m
//  ACME-Shopping
//
//  Created by fady on 13-10-24.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "HomeScrollView.h"
#import "HomeTableVIew.h"
#import "CustomModel.h"
#import "IndexModel.h"
#import "RFQuiltLayout.h"
#import "MoreCollectionView.h"
#import "CommodityView.h"
#import "BaseViewController.h"

@implementation HomeScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initViews];
    }
    return self;
}

-(void)_initViews
{
    self.delegate = self;
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.userInteractionEnabled = YES;
    self.bounces = NO;

    [self setDelaysContentTouches:NO];
    
    _tableViews = [[NSMutableArray alloc] init];
    
}

-(void)setData:(id)data
{
    _data = data;
    // 加载标题视图
    [self _loadTitleView];
    HomeTableVIew *tableView = _tableViews[self.selectedIndex];
    [self.viewController hiddenLoding];
    tableView.hidden = NO;
    
    if ([data isKindOfClass:[NSArray class]]) {
        tableView.data = data;
        [tableView reloadData];
        
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        
        NSArray *indexArray = self.indexData;
        IndexModel *index = indexArray[self.selectedIndex];
        NSString *key = index.title;
        
        NSArray *array = [data objectForKey:key];
        NSDictionary *dic = [NSDictionary dictionaryWithObject:array forKey:key];
        tableView.data = dic;
    }
}

// 加载图片集视图
-(void)_loadTableView:(UIView *)superView
{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    HomeTableVIew *tableView = [[HomeTableVIew alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, superView.height-44-20) collectionViewLayout:layout];
    tableView.swipeDelegate = self;

    tableView.backgroundColor = [UIColor clearColor];
    [superView addSubview:tableView];
    [_tableViews addObject:tableView];
}

// 加载标题视图
-(void)_loadTitleView
{
    NSArray *data = self.indexData;
    
    UIView *backView = [self viewWithTag:20133];
    
    if (backView != nil) {
        return;
    }
    
    for (int i = 0; i < data.count; i++) {
        // 背景视图
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(self.width * i, 20, self.width, self.height - 44)];
        backView.tag = 20133;
        backView.backgroundColor = [UIColor clearColor];
        [self addSubview:backView];
        
        // 标题栏
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 44)];
        titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"title_nav_bg.png"]];
        [backView addSubview:titleView];
        // 标题
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleView.bounds];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
        titleLabel.backgroundColor = [UIColor clearColor];
        
        IndexModel *index = data[i];
        NSString *text = index.title;
        
        titleLabel.text = text;
        [titleView addSubview:titleLabel];
        
        // 索引按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10, (44 - 30)/2, 30, 30);
        [button setImage:[UIImage imageNamed:@"index_icon.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"index_icon_pressed.png"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
        
        // 加载图片集视图
        
        if (i == 0) {
            // 第一个界面
            [self _loadTableView:backView];
        } else {
            // 子界面
            RFQuiltLayout* layout = [[RFQuiltLayout alloc] init];
            layout.direction = UICollectionViewScrollDirectionVertical;
            layout.blockPixels = CGSizeMake(100, 100);
            
            MoreCollectionView *tableView = [[MoreCollectionView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, backView.height - 44-20) collectionViewLayout:layout];
            layout.delegate = tableView;
            tableView.pullDelegate = self;
            [backView addSubview:tableView];
            [_tableViews addObject:tableView];
        }
    }
    
    self.contentSize = CGSizeMake(kScreenWidth * data.count, self.height);
}

#pragma mark - buttonAction
-(void)buttonAction
{
    [self showIndexView];
}

#pragma mark - UIScrollView delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    float x = scrollView.contentOffset.x;
    if (x < 10) {
        [self showIndexView];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x/self.width;
    if (self.selectedIndex != page) {
        [self loadData:page];
    }

    self.selectedIndex = page;
}

// 调用代理方法加载数据
-(void)loadData:(long)page
{
    HomeTableVIew *tableView = _tableViews[page];
    if ([self.homeDelegate respondsToSelector:@selector(loadSubViewData:index:)]) {
        [self.homeDelegate loadSubViewData:tableView index:page];
    }
}

-(void)loadMoreData:(long)page
{
    HomeTableVIew *tableView = _tableViews[page];
    if ([self.homeDelegate respondsToSelector:@selector(loadSubViewMoreData:index:)]) {
        [self.homeDelegate loadSubViewMoreData:tableView index:page];
    }
}

#pragma mark - IndexTableViewDelegate
-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath tableView:(IndexTableView *)tableView
{
    UIView *superView = tableView.superview;
    [UIView animateWithDuration:0.3 animations:^{
        superView.left = -kScreenWidth;
    }];
    
    long page = indexPath.row;
    CGPoint point = self.contentOffset;
    point.x = page *kScreenWidth;
    self.contentOffset = point;
    
    if (page != self.selectedIndex) {
        [self loadData:page];
    }
    
    self.selectedIndex = page;
}

-(void)scrollViewToNext
{
    int page = self.selectedIndex;
    page++;
    CGPoint point = self.contentOffset;
    point.x = page *kScreenWidth;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.contentOffset = point;
    }];
    
    self.selectedIndex = page;
    
    [self loadData:page];
}

-(void)showIndexView
{
    if ([self.homeDelegate respondsToSelector:@selector(showIndexView:)]) {
        [self.homeDelegate showIndexView:self];
    }
}


-(void)pullDown:(BaseCollectionView *)tableView
{
    int page = self.selectedIndex;
    [self loadData:page];
}

-(void)pullUp:(BaseCollectionView *)tableView
{
    [self loadMoreData:self.selectedIndex];
}

@end
