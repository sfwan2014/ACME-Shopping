//
//  ProfileTableView.m
//  ACME-Shopping
//
//  Created by fady on 13-11-2.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "ProfileTableView.h"
#import "ProfileCell.h"
#import "WebViewController.h"
#import "LovingViewController.h"
#import "MynoteViewController.h"

@implementation ProfileTableView
{
    NSArray *imageNames;
    NSArray *titles;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.bounces = NO;
    
    self.dataSource = self;
    self.delegate = self;
    
    imageNames = @[@[@"ge_ren_zhong_xin_gou_wu_che.png",
                     @"ge_ren_zhong_xin_ding_dan.png"],
                   
                   @[@"ge_ren_zhong_xin_xi_huan.png",
                     @"quanzi_icon.png",
                     @"ge_ren_zhong_xin_xiao_xi.png",
                     @"ge_ren_zhong_xin_li_shi.png"]];
    
    titles = @[@[@"我的购物车",
                 @"我的订单"],
               
               @[@"我的喜欢",
                 @"我的帖子",
                 @"我的消息",
                 @"最近浏览"]];
    
}

-(void)setUsername:(NSString *)username
{
    _username = username;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    label.font = [UIFont systemFontOfSize:13];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.text = [NSString stringWithFormat:@"Hi!%@", username];
    self.tableHeaderView = label;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"CellId";
    ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil) {
        cell = [[ProfileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    NSArray *array1 = imageNames[indexPath.section];
    NSArray *array2 = titles[indexPath.section];
    cell.imgName = array1[indexPath.row];
    cell.title = array2[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            WebViewController *webViewCtrl = [[WebViewController alloc] init];
            webViewCtrl.url = @"http://h5.m.taobao.com/awp/base/cart.htm";
            webViewCtrl.title = @"我的收藏";
            [self.viewController.navigationController pushViewController:webViewCtrl animated:YES];
        } else if (indexPath.row == 1) {
            WebViewController *webViewCtrl = [[WebViewController alloc] init];
            webViewCtrl.url = @"http://h5.m.taobao.com/my/index.htm?ttid=215200%40wht00180_android_1.2.0";
            webViewCtrl.title = @"我的订单";
            [self.viewController.navigationController pushViewController:webViewCtrl animated:YES];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            LovingViewController *lovingCtrl = [[LovingViewController alloc] init];
            
            [self.viewController.navigationController pushViewController:lovingCtrl animated:YES];
        } else if (indexPath.row == 1) {
            MynoteViewController *noteCtrl = [[MynoteViewController alloc] init];
            
            [self.viewController.navigationController pushViewController:noteCtrl animated:YES];
        }
    }
}

@end
