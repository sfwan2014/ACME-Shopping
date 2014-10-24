//
//  ReplyCell.h
//  ACME-Shopping
//
//  Created by fady on 13-11-1.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseCell.h"

@class NoteModel;
@interface ReplyCell : BaseCell

@property(nonatomic, strong)NoteModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

+(CGFloat)CellHeight:(NoteModel *)model;

@end
