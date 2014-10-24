//
//  MoreCollectionCell.m
//  ACME-Shopping
//
//  Created by fady on 13-10-25.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "MoreCollectionCell.h"
#import "PageModel.h"
#import "ListModel.h"

@implementation MoreCollectionCell

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

-(void)setModel:(BaseModel *)model
{
    _model = model;
    
//    CGSize size = [MoreCollectionCell getContentSize:model];
//    self.width = size.width;
    
    [self setNeedsLayout];
}

-(void)_loadSubViews
{
    _imageView = [[CommodityView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_imageView];
//    _imageView.userInteractionEnabled = YES;
    _imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _imageView.layer.borderWidth = 1;
    _imageView.backgroundColor = [UIColor grayColor];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _priceLabel.font = [UIFont systemFontOfSize:9];
    _priceLabel.backgroundColor = [UIColor redColor];
    _priceLabel.textColor = [UIColor whiteColor];
//    [_imageView addSubview:_priceLabel];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    NSString *urlstring = nil;
    NSString *price = nil;
    if ([_model isKindOfClass:[PageModel class]]) {
        PageModel *model = (PageModel*)_model;
        urlstring = model.bitmapurl;
        
        NSString *uri = model.uri;
        NSArray *array = [uri componentsSeparatedByString:@","];
        
        price = [array lastObject];
        
    } else if ([_model isKindOfClass:[ListModel class]]){
        
        ListModel *model = (ListModel *)_model;
        urlstring = model.pic_url;
        
        price = [NSString stringWithFormat:@"%@", model.price];
    }
        
    _imageView.frame = self.bounds;
    _imageView.model = _model;
    _imageView.layer.masksToBounds = YES;
    [_imageView setImageWithURL:[NSURL URLWithString:urlstring]];
    
    _priceLabel.frame = CGRectMake(_imageView.right - 30, _imageView.bottom-20, 30, 20);
    _priceLabel.text = price;
    
    [_priceLabel sizeToFit];
}

/*
 "rect": {
 "b": 5232,
 "id": -1,
 "l": 162,
 "r": 480,
 "t": 4906
 */
+(CGSize)getContentSize:(PageModel *)model
{
    NSDictionary *rect = model.rect;
    float b = [[rect objectForKey:@"b"] floatValue];
    float l = [[rect objectForKey:@"l"] floatValue];
    float r = [[rect objectForKey:@"r"] floatValue];
    float t = [[rect objectForKey:@"t"] floatValue];
    
    float width = r - l;
    float height = b - t;
    float m = 320/500.0;

    
    CGSize size = CGSizeMake(width*m, height*m);
    return size;
}

@end
