//
//  CircleView.h
//  ACME-Shopping
//
//  Created by fady on 13-10-31.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CircleModel;
@interface CircleView : UIView

@property(nonatomic, strong)CircleModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *replyImageView;


+(CGFloat)circleHeightFromModel:(CircleModel *)model;

@end
