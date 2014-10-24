//
//  ProfileCell.m
//  ACME-Shopping
//
//  Created by fady on 13-11-2.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "ProfileCell.h"

@implementation ProfileCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self _initViews];
}

-(void)_initViews
{
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_imgView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_titleLabel];
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _imgView.frame = CGRectMake(10, 10, 20, 20);
    _imgView.image = [UIImage imageNamed:_imgName];
    
    _titleLabel.frame = CGRectMake(_imgView.right + 5, 0, 200, self.height);
    _titleLabel.text = _title;
}

@end
