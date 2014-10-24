//
//  CircleView.m
//  ACME-Shopping
//
//  Created by fady on 13-10-31.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "CircleView.h"
#import "CircleModel.h"

#define kImageHeight 74
#define kNickImageHeight 61

#define knicklabelHeight 14
#define kCreateTimeLabel 21

@implementation CircleView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 0.4;
}

-(void)setModel:(CircleModel *)model
{
    _model = model;
    
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    
    
    [super layoutSubviews];
    
    NSString *authorPic = _model.authorPic;
    [self.userImage setImageWithURL:[NSURL URLWithString:authorPic]];
    
    self.nickLabel.text = _model.authorNick;
    
    // 2013-10-30 15:18:32
    NSString *createTime = _model.createTime;
    NSDate *date = [UIUtils dateFromString:createTime formate:@"yyyy-MM-dd HH:mm:ss"];
    NSString *datestring = [UIUtils stringFromDate:date formate:@"MM月dd日 hh:mm"];
    self.timeLabel.text = [NSString stringWithFormat:@"发布于: %@", datestring];
    
    if (_model.originalPic.length > 0) {
        self.imgView.hidden = NO;
        [self.imgView setImageWithURL:[NSURL URLWithString:_model.originalPic]];
    } else {
        self.imgView.hidden = YES;
    }
    
    self.replyLabel.text = [_model.replayCount stringValue];
    
    NSString *text = _model.content;
    if (_model.item != nil) {
        text = [NSString stringWithFormat:@"[晒宝贝] %@", _model.content];
        
        NSDictionary *item = _model.item;
        NSString *picUrl = [item objectForKey:@"picUrl"];
        
        if (picUrl.length > 0) {
            self.imgView.hidden = NO;
            [self.imgView setImageWithURL:[NSURL URLWithString:picUrl]];
        } else {
            self.imgView.hidden = YES;
        }
    }
    
    self.commentLabel.text = text;
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(214, 1000)];
    
    self.commentLabel.height = size.height;
    
    self.imgView.top = self.commentLabel.bottom + 5;
    self.replyLabel.bottom = self.height-5;
    self.replyImageView.bottom = self.height-5;
}


+(CGFloat)circleHeightFromModel:(CircleModel *)model
{
    float height = 0;
    
    height += knicklabelHeight;
    height += kCreateTimeLabel;
    
    NSString *text = model.content;
    if (model.item != nil) {
        text = [NSString stringWithFormat:@"[晒宝贝] %@", model.content];
        
        NSDictionary *item = model.item;
        NSString *picUrl = [item objectForKey:@"picUrl"];
        if (picUrl.length > 0) {
            
            height += (kImageHeight + 5);
        }
    }
    
    if (model.originalPic.length > 0) {
        height += (kImageHeight+5);
    }
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(180, 1000)];
    height += size.height;
    
    if (height < kNickImageHeight) {
        height = kNickImageHeight + 10;
    }
    
    return height+23;
}

@end
