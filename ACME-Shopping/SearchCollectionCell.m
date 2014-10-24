//
//  CollectionCell.m
//  ACME-Shopping
//
//  Created by fady on 13-10-24.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "SearchCollectionCell.h"
#import "SearchModel.h"
#import "ItemModel.h"

@implementation SearchCollectionCell
{
    NSMutableArray *array;
    UILabel *titleLabel;
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
    
    [self setNeedsLayout];
}


-(void)_loadSubViews
{
    self.backgroundColor = [UIColor clearColor];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:titleLabel];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    titleLabel.frame = self.bounds;
    
    titleLabel.text = _model.title;
}

//-(void)setIsDraw:(BOOL)isDraw
//{
//    _isDraw = isDraw;
//
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 60)/2, 0, 60, 20)];
//    label.textColor = [UIColor blackColor];
//    label.font = [UIFont systemFontOfSize:12];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.text = self.text;
//    label.backgroundColor = [UIColor clearColor];
//    [self.contentView addSubview:label];
//    [self setNeedsDisplay];
//}

//-(void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//    //    rect = CGRectMake(0, self.height/2, self.width, 20);
//    if (self.isDraw) {
//        // 获取画笔
//        CGContextRef ctx = UIGraphicsGetCurrentContext();
//        //设置线条宽度
//        CGContextSetLineWidth(ctx, 1);
//        // 设置画笔颜色
//        CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
//        
//        for (int i = 10; i < kScreenWidth - 10; i++) {
//            CGContextMoveToPoint(ctx, i, rect.size.height/2);
//            
//            if (i < (kScreenWidth - 60)/2 + 60 && i > (kScreenWidth - 60)/2) {
//                continue;
//                
//            }
//            CGContextAddLineToPoint(ctx, i+1, rect.size.height/2);
//            
//        }
//        CGContextDrawPath(ctx, kCGPathStroke);
//        
//    }
//}


@end
