//
//  CommentTableView.m
//  ACME-Shopping
//
//  Created by fady on 13-10-30.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "CommentTableView.h"
#import "CommentCell.h"

@implementation CommentTableView

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cellId";
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == Nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:nil options:nil] lastObject];
    }
    
    cell.model = self.data[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

@end
