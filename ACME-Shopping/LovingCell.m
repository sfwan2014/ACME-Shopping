//
//  LovingCell.m
//  ACME-Shopping
//
//  Created by fady on 13-11-2.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "LovingCell.h"
#import "DetailModel.h"
#import "ItemDB.h"
@implementation LovingCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _loadView];
    }
    
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self _loadView];
}

-(void)_loadView
{
    _imgView = [[UIImageView alloc] initWithFrame:self.bounds];
    _imgView.tag = 2013;
    _imgView.userInteractionEnabled = YES;
    _imgView.backgroundColor = [UIColor grayColor];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 40, self.height - 20, 40, 20)];
    priceLabel.font = [UIFont systemFontOfSize:10];
    priceLabel.textColor = [UIColor whiteColor];
    priceLabel.backgroundColor = [UIColor grayColor];
    priceLabel.tag = 2014;
    
    [_imgView addSubview:priceLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"delete_like.png"] forState:UIControlStateNormal];
    button.tag = 2015;
    [button addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(self.width - 20, 0, 20, 20);
    
    [_imgView addSubview:button];
    
    [self.contentView addSubview:_imgView];
}

-(void)setModel:(DetailModel *)model
{
    _model = model;
    
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    UILabel *priceLabel = (UILabel *)[self.contentView viewWithTag:2014];
    
    NSString *urlstring = _model.picUrl;
    [_imgView setImageWithURL:[NSURL URLWithString:urlstring]];
    
    float price = [_model.promotionPrice doubleValue];
    priceLabel.text = [NSString stringWithFormat:@"%0.2f",price/100.0];
    
    UIButton *button = (UIButton *)[self.contentView viewWithTag:2015];
    if (self.isDelete) {
        button.hidden = NO;
//        [UIView animateWithDuration:0.05 animations:^{
//            [UIView setAnimationRepeatCount:1000000];
//            _imgView.transform = CGAffineTransformRotate(self.transform, M_PI/128.0);
//        } completion:^(BOOL finished) {
//            _imgView.transform = CGAffineTransformRotate(self.transform, -M_PI/128.0);
//        }];
    } else {
        button.hidden = YES;
//      _imgView.transform = CGAffineTransformIdentity;
        [_imgView.layer removeAllAnimations];
    }
    
    _imgView.superview.alpha = 1;
}

-(void)deleteAction
{
    
    [[ItemDB shareDB] deleteItem:[NSString stringWithFormat:@"%@", self.model.numIid]];

    if ([self.deleteDelegate respondsToSelector:@selector(deleteFinish:)]) {
        [self.deleteDelegate deleteFinish:self];
    }
    [UIView animateWithDuration:0.8 animations:^{
        self.contentView.alpha = 0;
        self.transform = CGAffineTransformScale(self.transform, 0.4, 0.4);
    }];
}

@end
