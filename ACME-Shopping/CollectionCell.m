//
//  CollectionCell.m
//  ACME-Shopping
//
//  Created by fady on 13-10-24.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "CollectionCell.h"
#import "ItemModel.h"
#import "PageModel.h"

@implementation CollectionCell
{
    NSMutableArray *array;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _loadSubViews];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self _loadSubViews];
}

-(void)setModel:(ItemModel *)model
{
    _model = model;

    CGSize size = [CollectionCell getContentSize:model];
    self.width = size.width;
    
    if (_imageView.superview == Nil) {
        
        [self.contentView addSubview:_imageView];
        
        if (changeView.superview != nil) {
            [changeView removeFromSuperview];
        }
    }
    
    [self setNeedsLayout];
}

-(void)setData:(NSArray *)data
{
    _data = data;
    changeView = [AnimationView sharenInstance];
    changeView.frame = self.bounds;
    changeView.data = data;
    if (changeView.superview == Nil) {
        
        [self.contentView addSubview:changeView];
        [_imageView removeFromSuperview];
    }
    
//    if (_imageView != nil) {
//        [_imageView removeFromSuperview];
//    }
}

-(void)_loadSubViews
{
    array = [[NSMutableArray alloc] init];
    
    _imageView = [[CommodityView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_imageView];
    _imageView.userInteractionEnabled = YES;
    
    self.contentView.backgroundColor = [UIColor clearColor];
    // 背景颜色会显示
    self.backgroundColor = [UIColor clearColor];
    
    _itemLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _itemLabel.font = [UIFont systemFontOfSize:20];
    _itemLabel.numberOfLines = 0;
    _itemLabel.textAlignment = NSTextAlignmentCenter;
    _itemLabel.textColor = [UIColor whiteColor];
    _itemLabel.hidden = YES;
    [_imageView addSubview:_itemLabel];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _priceLabel.font = [UIFont systemFontOfSize:9];
    _priceLabel.backgroundColor = [UIColor grayColor];
    _priceLabel.textColor = [UIColor whiteColor];
    [_imageView addSubview:_priceLabel];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSString *urlstring = _model.image;
    if (![_model.mtype isEqualToString:@"image"]) {

        _imageView.frame = self.bounds;
        if ([_model.type isEqualToString:@"info"]) {
            _itemLabel.hidden = NO;
            _itemLabel.text = _model.title;
            
            if ([_model.title isEqualToString:@"签到暂停"]) {
                _imageView.backgroundColor = rgb(255, 133, 85, 0.5);
            } else if ([_model.title isEqualToString:@"男休闲鞋"]) {
                _imageView.backgroundColor = rgb(183, 183, 183, 0.5);
            } else if ([_model.title isEqualToString:@"潮流女装"]) {
                _imageView.backgroundColor = rgb(177, 117, 96, 0.5);
            }
            
            _imageView.image = nil;
            _itemLabel.frame = _imageView.bounds;
            _itemLabel.width = _imageView.width/2;
        } else {
            _itemLabel.hidden = YES;
            
            [_imageView setImageWithURL:[NSURL URLWithString:urlstring]];
        }
        
        _imageView.model = _model;
    }
    
}

-(void)setIsDraw:(BOOL)isDraw
{
    _isDraw = isDraw;
    
//    CGRect frame = CGRectMake(50, (self.height - 20)/2, self.width, 20);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 60)/2, 0, 60, 20)];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.text;
    label.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:label];
    [self setNeedsDisplay];
}


+(CGSize)getContentSize:(ItemModel *)model
{
    if ([model.mtype isEqualToString:@"image"]) {
        return CGSizeMake(320, 100);
    } else if ([model.mtype isEqualToString:@"infoImage"]) {
        return CGSizeMake(100, 100);
    } else if ([model.mtype isEqualToString:@"newItems"]) {
        return CGSizeMake(155, 157);
    } else if ([model.mtype isEqualToString:@"topItems"]) {
        return CGSizeMake(100, 120);
    }
    
    return CGSizeMake(0, 0);
}

@end
