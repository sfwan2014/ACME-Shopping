//
//  DetailHeaderView.m
//  ACME-Shopping
//
//  Created by fady on 13-10-29.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "DetailHeaderView.h"
#import "DetailModel.h"
#import "WebViewController.h"
#import "ZoomImageView.h"

@implementation DetailHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
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

-(void)setModel:(DetailModel *)model
{
    _model = model;
    
    NSArray *array = model.itemImgs;
    NSMutableArray *urls = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dic in array) {
        NSString *url = [dic objectForKey:@"url"];
        [urls addObject:url];
    }
    
    self.data = urls;
    
    [self _initScrollView];
    
    [self setNeedsLayout];
}

-(void)_initViews
{
    self.purchButton = [[PurchButton alloc] initWithFrame:CGRectMake(10, 243, 164, 24)];
    [self.purchButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.purchButton];
}

-(void)_initScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.pictureView.bounds];
    scrollView.bounces = NO;
    scrollView.bounces = NO;
    [self.pictureView addSubview:scrollView];
    float width = 170;
    
    scrollView.contentSize = CGSizeMake(170*self.data.count, self.pictureView.height);
    
    for (int i = 0; i < self.data.count; i++) {
        ZoomImageView *imageView = [[ZoomImageView alloc] initWithFrame:CGRectMake(i*width, 0, width-3, self.pictureView.height)];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i+100;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tap];
        
        [scrollView addSubview:imageView];
    }
    
    for (int i = 0; i < self.data.count; i++) {
        ZoomImageView *imageView = (ZoomImageView *)[scrollView viewWithTag:i+100];
        
        NSString *urlstring = self.data[i];
        [imageView addZoom:urlstring];
        [imageView setImageWithURL:[NSURL URLWithString:urlstring]];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.commentLabel.text = [NSString stringWithFormat:@"%@", _model.evaluateCount];
    self.lovingLabel.text = [NSString stringWithFormat:@"%@", _model.favoriteCount];
    self.saleLabl.text = [NSString stringWithFormat:@"%@", _model.volume];
    self.detailLabel.text = _model.title;
    float promotionPrice = [_model.promotionPrice floatValue];
    float price = [_model.price floatValue];
    
    if (price!= 0 || promotionPrice != 0) {
        NSString *priceText = [NSString stringWithFormat:@"￥%.2f", price/100];
        
        if (promotionPrice != 0) {
            priceText = [NSString stringWithFormat:@"￥%.2f~￥%.2f", promotionPrice/100, price/100];
        }
        
        CGSize size = [priceText sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(1000, 25)];
        self.purchButton.width = size.width + 40 + 1+ 10;
        self.purchButton.price = priceText;
    }
}

- (IBAction)buttonAction:(UIButton *)sender {
    
    // http://h5.m.taobao.com/awp/core/detail.htm?id=12592327821&ali_trackid=2:mm_27400360_0_0:1383648134_6k1_905197389&sid=c7a93d2dfbcb47564bfdb75d9904a1d6&ttid=400000_21422441%40whttk_android_1.2.0
    NSString *urlstring = [NSString stringWithFormat:@"http://h5.m.taobao.com/awp/core/detail.htm?id=%@&ali_trackid=2:mm_27400360_0_0:1383648134_6k1_905197389&sid=c7a93d2dfbcb47564bfdb75d9904a1d6&ttid=400000_21422441%%40whttk_android_1.2.0", [_model.numIid stringValue]];
    WebViewController *webView = [[WebViewController alloc] init];
    webView.url = urlstring;
    
    [self.viewController.navigationController pushViewController:webView animated:YES];
}

-(void)tapAction:(UITapGestureRecognizer *)tap
{
    if (tap.view.tag == 100) {
        
    }
    NSLog(@"放大");
}

@end
