//
//  LovingViewController.m
//  ACME-Shopping
//
//  Created by fady on 13-11-2.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "LovingViewController.h"
#import "ItemDB.h"

@interface LovingViewController ()

@end

@implementation LovingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.isDelete = YES;
        self.title = @"我的喜欢";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.isDelete) {
        [self _loadDeleteItem];
    }
    
    [super showLoadingInView:self.view];
    self.tableView.hidden = YES;
    
    [self _loadDBData];
    
    self.tableView.selectedBlock = self.block;
}

-(void)_loadDBData
{
    ItemDB *DB = [ItemDB shareDB];
    __weak LovingViewController *this = self;
    [DB findItems:^(NSArray *result) {
        __strong LovingViewController *strong = this;
        [strong afterLoadData:result];
    }];
}

-(void)afterLoadData:(NSArray *)result
{
    [super hiddenLoding];
    self.tableView.hidden = NO;
    
    self.tableView.data = result;
    [self.tableView reloadData];
}


-(void)_loadDeleteItem
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 25, 25);
    [button setImage:[UIImage imageNamed:@"delete_icon.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"queren.png"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)deleteAction:(UIButton *)button
{
    if (button.selected) {
        self.tableView.isDelete = NO;
    } else {
        self.tableView.isDelete = YES;
        __weak LovingViewController *this = self;
        self.tableView.block = ^(LovingCollectionView *tableView) {
            __strong LovingViewController *strong = this;
            
            [strong performSelector:@selector(_loadDBData) withObject:nil afterDelay:2];
        };
    }
    
    [self.tableView reloadData];
    
    button.selected = !button.selected;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self _loadDBData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
