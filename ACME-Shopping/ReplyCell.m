//
//  ReplyCell.m
//  ACME-Shopping
//
//  Created by fady on 13-11-1.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "ReplyCell.h"
#import "NoteModel.h"

#define kImageHeight 59
#define kNickHeight 21


@implementation ReplyCell

-(void)setModel:(NoteModel *)model
{
    _model = model;
    
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSString *replyUserPic = _model.replyUserPic;
    [self.userImage setImageWithURL:[NSURL URLWithString:replyUserPic]];
    
    NSString *content = _model.content;
    CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(219, 1000)];
    self.contentLabel.height = size.height;
    self.contentLabel.text = content;
    
    NSString *replyUserNick = _model.replyUserNick;
    self.nickLabel.text = replyUserNick;
    
    NSString *createTime = _model.createTime;
//    NSDate *date = [UIUtils dateFromString:createTime formate:@"yyyy-MM-dd HH:mm:ss"];
//    NSString *datastring = [UIUtils stringFromDate:date formate:@"MM月dd日 HH:mm"];
//    
//    NSDate *date2 = [NSDate date];
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *string = [dateFormatter stringFromDate:date2];
//    date2 = [dateFormatter dateFromString:string];
//    
//    NSTimeInterval timeInterval = [date2 timeIntervalSinceDate:date];
// 
//    double time = timeInterval;
//    if (time < 60*60*24*2) {
//        if (time > 60*60*24) {
//            datastring = [UIUtils stringFromDate:date formate:@"前天HH:mm"];
//        } else if(time > 0) {
//            datastring = [UIUtils stringFromDate:date formate:@"昨天HH:mm"];
//        } else {
//            datastring = [UIUtils stringFromDate:date formate:@"HH:mm"];
//        }
//    }
    NSString *datestring = [UIUtils stringFromNowDate:createTime];
    self.timeLabel.text = datestring;
}

+(CGFloat)CellHeight:(NoteModel *)model
{
    float height = 0;
    
    height += kNickHeight;
    
    NSString *content = model.content;

    CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(219, 1000)];
    height += size.height;
    
    if (height < kImageHeight) {
        height = kImageHeight;
    }
    
    return height;
}

@end
