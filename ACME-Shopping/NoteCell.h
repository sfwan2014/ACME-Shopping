//
//  NoteCell.h
//  ACME-Shopping
//
//  Created by fady on 13-11-2.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseCell.h"

@class CircleModel;
@interface NoteCell : BaseCell

@property(nonatomic, strong)CircleModel *model;

@property (weak, nonatomic) IBOutlet UILabel *contextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *replyImg;
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;

@end
