//
//  ReplayHeaderView.m
//  ACME-Shopping
//
//  Created by fady on 13-11-1.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "ReplayHeaderView.h"

@implementation ReplayHeaderView

-(void)setThread:(NSDictionary *)thread
{
    _thread = thread;
    
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSString *authorPic = [_thread objectForKey:@"authorPic"];
    [self.authorImg setImageWithURL:[NSURL URLWithString:authorPic]];
    
    BOOL isMaster = [[_thread objectForKey:@"isMaster"] boolValue];
    if (isMaster) {
        self.maskImageView.hidden = NO;
    } else {
        self.maskImageView.hidden = YES;
    }
    
    NSString *authorNick = [_thread objectForKey:@"authorNick"];
    self.nickLabel.text = authorNick;
    [self.nickLabel sizeToFit];
    self.maskImageView.left = self.nickLabel.right + 5;
    
    NSString *content = [_thread objectForKey:@"content"];
    self.contentLabel.text = content;
    
    // "2013-06-03 15:49:03
    NSString *createTime = [_thread objectForKey:@"createTime"];
    
    NSString *datastring = [UIUtils stringFromNowDate:createTime];
    self.timeLabel.text = [NSString stringWithFormat:@"发布于 %@", datastring];
    
    NSNumber *replayCount = [_thread objectForKey:@"replayCount"];
    self.countLabel.text = [NSString stringWithFormat:@"(%@)", replayCount];

    
//    NSDictionary *item = [_thread objectForKey:@"item"];
    NSString *picUrl = [_thread objectForKey:@"picUrl"];
    if (picUrl.length > 0) {
        self.imgView.hidden = NO;
        [self.imgView setImageWithURL:[NSURL URLWithString:picUrl]];
//        self.timeLabel.top = self.imgView.bottom;

    } else {
        self.imgView.hidden = YES;
//        self.timeLabel.top = self.contentLabel.bottom + 5;
    }
    
}

@end
