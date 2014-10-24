//
//  DetailFootView.m
//  ACME-Shopping
//
//  Created by fady on 13-10-29.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "DetailFootView.h"
#import "DetailViewController.h"

@implementation DetailFootView
{
    NSArray *urlArray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setData:(NSArray *)data
{
    _data = data;
    urlArray = [[NSArray alloc] init];
    NSMutableArray *urls = [NSMutableArray arrayWithCapacity:data.count ];
    for (NSDictionary *dic in data) {
        NSString *url = [dic objectForKey:@"picUrl"];
        [urls addObject:url];
    }
    
    urlArray = urls;
    
    [self _initScrollView];
}

-(void)_initScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.pictureView.bounds];
    scrollView.bounces = NO;
    scrollView.height = self.pictureView.height;
    [self.pictureView addSubview:scrollView];
    float width = 120;
    
    scrollView.contentSize = CGSizeMake(120*urlArray.count, self.pictureView.height);
    
    for (int i = 0; i < urlArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*width, 0, width-3, self.pictureView.height)];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i+100;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tap];
        
        [scrollView addSubview:imageView];
    }
    
    for (int i = 0; i < urlArray.count; i++) {
        UIImageView *imageView = (UIImageView *)[scrollView viewWithTag:i+100];
        
        NSString *urlstring = urlArray[i];
        
        [imageView setImageWithURL:[NSURL URLWithString:urlstring]];
    }
}

-(void)tapAction:(UITapGestureRecognizer *)tap
{
    int index = tap.view.tag - 100;
    NSDictionary *dic = self.data[index];
    NSString *numIid = [[dic objectForKey:@"numIid"] stringValue];
    DetailViewController *detailCtrl = [[DetailViewController alloc] init];
    detailCtrl.numId = numIid;
    
    [self.viewController.navigationController pushViewController:detailCtrl animated:YES];
}

@end
