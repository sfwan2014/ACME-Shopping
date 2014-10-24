//
//  AnimationView.m
//  ACME-Shopping
//
//  Created by fady on 13-10-25.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "AnimationView.h"
#import "ItemModel.h"

@implementation AnimationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.userInteractionEnabled = YES;
    }
    return self;
}

static AnimationView *instance = nil;

+(id)sharenInstance
{
    @synchronized(self) {
        if (instance == nil) {
            instance = [[[self class] alloc] initWithFrame:CGRectZero];
        }
    }
    
    return instance;
}

-(void)setData:(NSArray *)data
{
    _data = data;
    
    if (!self.isCreate) {
        for (int i = 0; i < data.count; i++) {
            ItemModel *model = data[i];
            CommodityView *subView = [[CommodityView alloc] initWithFrame:self.bounds];
            subView.top = -100;
            if (i == 0) {
                subView.top = 0;
            }
            NSString *urlstring = model.image;
            [subView setImageWithURL:[NSURL URLWithString:urlstring]];
            subView.model = model;
            [self addSubview:subView];
            self.isCreate = YES;
        }
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
        
//        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction1)];
//        swipe.direction = UISwipeGestureRecognizerDirectionUp |UISwipeGestureRecognizerDirectionDown ;
//        [self addGestureRecognizer:swipe];
    }
}

-(void)timeAction
{
    static int time1 = 1;
    static int time2 = 0;
    NSArray *subViews = [instance subviews];
    
    if (time1 >= subViews.count - 1) {
        time1 = 0;
    }
    
    
    UIImageView *imageView1 = subViews[time2];
    UIImageView *imageView2 = subViews[time1];
    
    //    [self bringSubviewToFront:imageView1];
    //    [self bringSubviewToFront:imageView2];
    //    [self insertSubview:imageView2 belowSubview:self];
    imageView2.top = -100;
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView animateWithDuration:1 animations:^{
        imageView1.top = 100;
        imageView2.top = 0;
    } completion:^(BOOL finished) {
        imageView1.top = -100;
    }];
    
    time2 = time1;
    time1++;
}

//-(void)swipeAction1
//{
//    [self timeAction];
//}

@end
