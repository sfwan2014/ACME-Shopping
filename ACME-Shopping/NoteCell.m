//
//  NoteCell.m
//  ACME-Shopping
//
//  Created by fady on 13-11-2.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "NoteCell.h"
#import "CircleModel.h"

@implementation NoteCell

-(void)setModel:(CircleModel *)model
{
    _model = model;
    
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    NSDictionary *itemDic = _model.item;
    NSString *picUrl = [itemDic objectForKey:@"picUrl"];
    [self.userImage setImageWithURL:[NSURL URLWithString:picUrl]];
    self.contextLabel.text = _model.content;
    self.replyLabel.text = [NSString stringWithFormat:@"(%@)", _model.replayCount];
    
    NSString *createTime = _model.createTime;
    
    NSDate *date = [UIUtils dateFromString:createTime formate:@"yyyy-MM-dd HH:mm:ss"];
    NSString *datastring = [UIUtils stringFromDate:date formate:@"发布于 MM月dd日 HH:mm"];
    
    NSDate *date2 = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *string = [dateFormatter stringFromDate:date2];
    date2 = [dateFormatter dateFromString:string];
    
    NSTimeInterval timeInterval = [date2 timeIntervalSinceDate:date];
    
    double time = timeInterval;
    if (time < 60*60*24*2) {
        if (time > 60*60*24) {
            datastring = [UIUtils stringFromDate:date formate:@"发布于 前天HH:mm"];
        } else if(time > 0) {
            datastring = [UIUtils stringFromDate:date formate:@"发布于 昨天HH:mm"];
        } else {
            datastring = [UIUtils stringFromDate:date formate:@"发布于 HH:mm"];
        }
    }
    
    self.timeLabel.text = datastring;
}


@end
