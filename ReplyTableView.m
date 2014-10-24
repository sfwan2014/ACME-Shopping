//
//  ReplyTableView.m
//  ACME-Shopping
//
//  Created by fady on 13-11-1.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "ReplyTableView.h"
#import "ReplyCell.h"
#import "ReplayHeaderView.h"

@implementation ReplyTableView

-(void)setThread:(NSDictionary *)thread
{
    _thread = thread;
    
    ReplayHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"ReplayHeaderView" owner:Nil options:Nil] lastObject];

    headerView.thread = thread;
    headerView.backgroundColor = [UIColor redColor];
    float height = 1;
    NSDictionary *item = [_thread objectForKey:@"item"];
    NSString *picUrl = [item objectForKey:@"picUrl"];
    if (picUrl.length == 0) {
        height = 100;
    }
    
    self.tableHeaderView = headerView;
    headerView.height = headerView.height - height;
    self.tableHeaderView.height = headerView.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cellId";
    ReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ReplyCell" owner:nil options:nil] lastObject];
    }
    
    cell.model = self.data[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float heigth = [ReplyCell CellHeight:self.data[indexPath.row]];
    
    return heigth+30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld", indexPath.row);
}

@end
