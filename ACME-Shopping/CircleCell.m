//
//  CircleCell.m
//  ACME-Shopping
//
//  Created by fady on 13-10-31.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "CircleCell.h"
#import "CircleView.h"

@implementation CircleCell
{
    CircleView *circleView;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
    }
    
    return self;
}

-(void)_initViews
{
    circleView = [[[NSBundle mainBundle] loadNibNamed:@"CircleView" owner:nil options:nil] lastObject];
    [self.contentView addSubview:circleView];
}

-(void)setModel:(CircleModel *)model
{
    _model = model;
    
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    circleView.frame = self.bounds;
    circleView.model = _model;
}

@end
