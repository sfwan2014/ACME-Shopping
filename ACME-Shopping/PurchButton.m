//
//  PurchButton.m
//  ACME-Shopping
//
//  Created by fady on 13-10-29.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "PurchButton.h"

@implementation PurchButton
{
    UILabel *priceLabel;
    UILabel *titleLabel;
    UIImageView *backView;
}


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
//        [self _initViews];
    }
    
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)setPrice:(NSString *)price
{
    _price = price;
    
    [self _initViews];
}

-(void)_initViews
{
    
    backView = [[UIImageView alloc] initWithFrame:self.bounds];
    UIImage *image = [UIImage imageNamed:@"price_bg_2.9.png"];
    image = [image stretchableImageWithLeftCapWidth:10 topCapHeight:0];
    backView.image = image;
    backView.backgroundColor = [UIColor clearColor];
    backView.userInteractionEnabled = YES;
    
    [self addSubview:backView];
    
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width/2+5, self.height)];
    priceLabel.backgroundColor = [UIColor clearColor];
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.textColor = [UIColor whiteColor];
    priceLabel.font = [UIFont systemFontOfSize:14];
    [backView addSubview:priceLabel];
    
    UIView *separateView = [[UIView alloc] initWithFrame:CGRectMake(priceLabel.right, 0, 1, self.height)];
    separateView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    [self addSubview:separateView];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(priceLabel.right+1, 0, 40, self.height)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:14];
    [backView addSubview:titleLabel];
    titleLabel.text = @"购买";
    
    
    CGSize size = [_price sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(1000, 25)];
    
    priceLabel.width = size.width;
    separateView.left = priceLabel.right;
    titleLabel.left = priceLabel.right+1;
    
    priceLabel.text = _price;
}

-(void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (highlighted) {
        
        [UIView animateWithDuration:1 animations:^{
            
            UIImage *image = [UIImage imageNamed:@"price_bg_2_pressed.9.png"];
            image = [image stretchableImageWithLeftCapWidth:20 topCapHeight:0];
            backView.image = image;
            
        } completion:^(BOOL finished) {
            
            UIImage *image = [UIImage imageNamed:@"price_bg_2.9.png"];
            image = [image stretchableImageWithLeftCapWidth:20 topCapHeight:0];
            backView.image = image;
        }];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    [self setHighlighted:YES];
}


@end
