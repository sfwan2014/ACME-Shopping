//
//  MoreViewController.m
//  ACME-Shopping
//
//  Created by fady on 13-10-23.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "MoreViewController.h"
#import "ProfileCell.h"
#import "SDImageCache.h"
#import "ZZAboutViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController
{
    NSArray *imageNames;
    NSArray *titles;
    long long sum;
}

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
	
    self.title = @"更多";
    
    imageNames = @[@[@"icon_recommend.png",
                     @"icon_feedback.png"],
                   
                   @[@"icon_clean_cache.png",
                     @"icon_refresh.png",
                     @"icon_about.png"]];
    
    titles = @[@[@"推荐朋友",
                 @"意见反馈"],
               
               @[@"清除缓存",
                 @"检查更新",
                 @"关于我们"]];
    self.tableView.bounces = NO;
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
    
    return 3;
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
    
    NSString *title = array2[indexPath.row];
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            float s = sum/(1024*1024.0);
            title = [NSString stringWithFormat:@"%@            %0.1fM", array2[indexPath.row], s];
        }
    }
    
    cell.title = title;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"清除缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        } else if (indexPath.row == 2) {
            ZZAboutViewController *aboutCtrl = [[ZZAboutViewController alloc] init];
            [self.navigationController pushViewController:aboutCtrl animated:YES];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        return;
    } else if (buttonIndex == 1) {
        [[SDImageCache sharedImageCache] clearDisk];
        [self calculateCaches];
        [self.tableView reloadData];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self calculateCaches];
    [self.tableView reloadData];
}

-(void)calculateCaches
{
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/ImageCache"];
    
    sum = [UIUtils countDirectorySize:directory];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
