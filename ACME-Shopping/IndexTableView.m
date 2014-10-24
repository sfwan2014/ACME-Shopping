//
//  IndexTableView.m
//  ACME-Shopping
//
//  Created by fady on 13-10-24.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "IndexTableView.h"
#import "IndexModel.h"
#import "ItemModel.h"

@implementation IndexTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"selectedIndex"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pinDaoChange:) name:kPinDaoChangeNotification object:Nil];
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"selectedIndex"]) {
        int page = [[change objectForKey:@"new"] intValue];
        [[NSUserDefaults standardUserDefaults] setInteger:page forKey:@"selectedIndex"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self reloadData];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        // 去背景
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.backgroundView = nil;
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    NSInteger selectedIndex = [[NSUserDefaults standardUserDefaults] integerForKey:@"selectedIndex"];
    
    if (indexPath.row == selectedIndex) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.text = @"趣购时尚";
    IndexModel *index = self.data[indexPath.row];
    cell.textLabel.text = index.title;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self _jumpToIndex:indexPath];
}

-(void)pinDaoChange:(NSNotification *)notification
{
    ItemModel *model = notification.object;
    NSString *title = [model.link objectForKey:@"title"];
    for (int i = 0; i < self.data.count; i++) {
        IndexModel *index = self.data[i];
        if ([index.title isEqualToString:title]) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self _jumpToIndex:indexPath];
        }
    }
}

-(void)_jumpToIndex:(NSIndexPath *)indexPath
{
    if ([self.selectedDelegate respondsToSelector:@selector(didSelectRowAtIndexPath:tableView:)]) {
        [self.selectedDelegate didSelectRowAtIndexPath:indexPath tableView:self];
    }
    
    [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"selectedIndex"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self reloadData];
}

@end
