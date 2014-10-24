//
//  SearchViewController.m
//  ACME-Shopping
//
//  Created by fady on 13-10-23.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchCollectionView.h"
#import "SearchCollectionCell.h"
#import "SearchModel.h"
#import "ItemModel.h"
#import "JSONKit.h"
#import "JSON.h"
#import "InputViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

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
    
    self.title = @"分类搜索";
    [super showLoadingInView:self.view];
    self.tableView.hidden = YES;
    
    [self _initViews];
    
//    [self _loadData];
    [self _loadLocationData];
}

-(void)_loadLocationData
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"list.geojson" ofType:nil];
//    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    NSString *string = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    NSLog(@"%@", error);
    NSDictionary *result = [string JSONValue];

    [self afterLoadData:result];
}

-(void)_loadData
{
    NSMutableDictionary *params = [UIUtils params:@"action" value:@"getGoodsList"];
    [params setObject:@"0E391624D1E7EDF092BD33C2F8CCDAAC" forKey:@"digest"];
    [params setObject:@"00180" forKey:@"fpoint"];
    [params setObject:@"itemService" forKey:@"module"];
    
    __weak SearchViewController *this = self;
    [ZZDataServier requestWithURL:@"" params:params httpMethod:@"POST" block:^(id result) {
        SearchViewController *thisS = this;
        [thisS afterLoadData:result];
    }];
}

-(void)afterLoadData:(NSDictionary *)result
{
    NSArray *goodsBeanList = [result objectForKey:@"goodsBeanList"];
    
    NSMutableDictionary *listDic = [NSMutableDictionary dictionaryWithCapacity:goodsBeanList.count];
    NSMutableArray *listNames = [NSMutableArray arrayWithCapacity:goodsBeanList.count];
    for (NSDictionary *dic in goodsBeanList) {
        NSArray *itemCatList = [dic objectForKey:@"itemCatList"];
        NSString *name = [dic objectForKey:@"name"];
        
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:itemCatList.count];
        for (NSDictionary *itemDic in itemCatList) {
            ItemModel *model = [[ItemModel alloc] initWithDataDic:itemDic];
            [models addObject:model];
        }
        
        [listDic setObject:models forKey:name];
        [listNames addObject:name];
    }
    
    [super hiddenLoding];
    self.tableView.hidden = NO;
    
    self.tableView.listNames = listNames;
    self.tableView.data = listDic;
    [self.tableView reloadData];
}

-(void)_initViews
{
    UIView *searchView = [[[NSBundle mainBundle] loadNibNamed:@"Search" owner:Nil options:Nil] lastObject];
    searchView.frame = CGRectMake(0, 0, kScreenWidth, 44);
    [self.view addSubview:searchView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchAction)];
    [searchView addGestureRecognizer:tap];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.tableView.collectionViewLayout;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;

    [self.tableView registerClass:[SearchCollectionCell class] forCellWithReuseIdentifier:kCellId];
    
    [self.tableView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ViewId"];
}

-(void)searchAction
{
    InputViewController *inputCtrl = [[InputViewController alloc] init];
    [self.navigationController pushViewController:inputCtrl animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
