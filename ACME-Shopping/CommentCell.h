//
//  CommentCell.h
//  ACME-Shopping
//
//  Created by fady on 13-10-30.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseCell.h"
#import "CommentModel.h"

@interface CommentCell : BaseCell

@property(nonatomic, strong)CommentModel *model;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end
