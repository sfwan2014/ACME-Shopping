//
//  HomeViewController.h
//  ACME-Shopping
//
//  Created by fady on 13-10-23.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseViewController.h"

@class IndexTableView;
@class HomeScrollView;
@class ASIFormDataRequest;
@interface HomeViewController : BaseViewController
{
    IndexTableView *_indexView;
    UIView *_backView;
    
    NSMutableArray *_indexData;
    
    HomeScrollView *_scrollView;
    
    NSDictionary *digestDic;
    
    NSMutableDictionary *_pageDic;
    int pageNum;
}

@property(nonatomic, strong)ASIFormDataRequest *request;
@property(nonatomic, strong)NSMutableArray *data;

@end
