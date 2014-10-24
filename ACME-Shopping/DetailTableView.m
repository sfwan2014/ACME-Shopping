//
//  DetailTableView.m
//  ACME-Shopping
//
//  Created by fady on 13-10-29.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "DetailTableView.h"
#import "DetailFootView.h"
#import "DetailHeaderView.h"
#import "DetailModel.h"
#import "WebViewController.h"
#import "CommentViewController.h"

@implementation DetailTableView
{
    DetailHeaderView *headerView;
    DetailFootView *footView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initViews];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self _initViews];
}

-(void)_initViews
{
    self.bounces = NO;
    self.showsVerticalScrollIndicator = NO;
    
    headerView = [[[NSBundle mainBundle] loadNibNamed:@"DetailHeaderView" owner:Nil options:Nil] lastObject];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 267);
    
    self.tableHeaderView = headerView;
    self.tableHeaderView.height = headerView.height;
    NSLog(@"%@", NSStringFromCGRect(self.tableHeaderView.frame));
    
    footView = [[[NSBundle mainBundle] loadNibNamed:@"DetailFootView" owner:nil options:nil] lastObject];
    footView.frame = CGRectMake(0, 0, kScreenWidth, 168);
    self.tableFooterView = footView;
    self.tableFooterView.height = footView.height;
}

-(void)setData:(NSArray *)data
{
    [super setData:data];
    
    DetailModel *model = data[0];
    headerView.model = model;
    
    NSArray *array = data[1];
    footView.data = array;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"图文详情";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"评价详情";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"宝贝属性";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
//        NSArray *array = self.viewController.navigationController.viewControllers;
//        
//        for (UIViewController *ctrl in array) {
//            if ([ctrl isKindOfClass:[UIViewController class]]) {
//                
//            }
//        }
        
        WebViewController *webViewCtrl = [[WebViewController alloc] init];
        DetailModel *model = self.data[0];
        webViewCtrl.url = model.wapDetailUrl;
        
        [self.viewController.navigationController pushViewController:webViewCtrl animated:YES];
        
    } else if (indexPath.row == 1) {
        CommentViewController *commentCtrl = [[CommentViewController alloc] init];
        commentCtrl.model = self.data[0];
        
        [self.viewController.navigationController pushViewController:commentCtrl animated:YES];
    } else if (indexPath.row == 2) {
        
    }
}

@end
