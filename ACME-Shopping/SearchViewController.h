//
//  SearchViewController.h
//  ACME-Shopping
//
//  Created by fady on 13-10-23.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseViewController.h"

@class SearchCollectionView;
@interface SearchViewController : BaseViewController

@property (weak, nonatomic) IBOutlet SearchCollectionView *tableView;
@end
