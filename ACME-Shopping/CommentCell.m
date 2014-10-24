//
//  CommentCell.m
//  ACME-Shopping
//
//  Created by fady on 13-10-30.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

-(void)setModel:(CommentModel *)model
{
    _model = model;
    
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSString *content = _model.content;
    self.titleLabel.text = content;
    
    self.nickName.text = _model.nick;
    
    // "2013-10-30 10:34:46",
    NSString *created = _model.created;
    NSDate *date = [UIUtils dateFromString:created formate:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [UIUtils stringFromDate:date formate:@"yyyy-MM-dd"];
    self.timeLabel.text = dateString;
}


@end
