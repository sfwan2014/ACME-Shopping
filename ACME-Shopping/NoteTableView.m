//
//  NoteTableView.m
//  ACME-Shopping
//
//  Created by fady on 13-11-2.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "NoteTableView.h"
#import "NoteCell.h"
#import "CircleModel.h"

@implementation NoteTableView
{
    UIImageView *headerView;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self _initViews];
}

-(void)_initViews
{
    headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
    
    UIImageView *userImg = [[UIImageView alloc] initWithFrame:CGRectMake(7, headerView.height - 57, 50, 50)];
    userImg.layer.borderColor = [UIColor whiteColor].CGColor;
    userImg.layer.borderWidth = 2;
    userImg.tag = 2013;
    [headerView addSubview:userImg];
    
    UILabel *nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(userImg.right + 10, userImg.top + 20, 150, 20)];
    nickLabel.font = [UIFont systemFontOfSize:12];
    nickLabel.textColor = [UIColor orangeColor];
    nickLabel.backgroundColor = [UIColor clearColor];
    nickLabel.tag = 2014;
    [headerView addSubview:nickLabel];
    
    self.tableHeaderView = headerView;
    self.tableHeaderView.height = headerView.height;
    
}

-(void)setData:(NSArray *)data
{
    [super setData:data];
    if (data.count > 0) {
        CircleModel *model = data[0];
        NSURL *url = [NSURL URLWithString:model.authorPic];
        [headerView setImageWithURL:url];
        UIImageView *userImg = (UIImageView *)[headerView viewWithTag:2013];
        [userImg setImageWithURL:url];
        
        UILabel *nickLabel = (UILabel *)[headerView viewWithTag:2014];
        nickLabel.text = model.authorNick;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"CellIdd";
    NoteCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NoteCell" owner:nil options:nil] lastObject];
    }
    
    cell.model = self.data[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

@end
