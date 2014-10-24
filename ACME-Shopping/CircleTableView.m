//
//  CircleTableView.m
//  ACME-Shopping
//
//  Created by fady on 13-10-31.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "CircleTableView.h"
#import "CircleCell.h"
#import "CircleView.h"
#import "NoteViewController.h"

@implementation CircleTableView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"CellId";
    CircleCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[CircleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    cell.model = self.data[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heigth = [CircleView circleHeightFromModel:self.data[indexPath.row]];
    
    return heigth;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoteViewController *noteCtrl = [[NoteViewController alloc] init];
    noteCtrl.model = self.data[indexPath.row];
    noteCtrl.ishomeButton = NO;
    [self.viewController.navigationController pushViewController:noteCtrl animated:YES];
}

@end
