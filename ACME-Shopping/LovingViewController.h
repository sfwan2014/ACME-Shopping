//
//  LovingViewController.h
//  ACME-Shopping
//
//  Created by fady on 13-11-2.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseViewController.h"
#import "LovingCollectionView.h"

@interface LovingViewController : BaseViewController
@property (weak, nonatomic) IBOutlet LovingCollectionView *tableView;

@property(nonatomic, assign)BOOL isDelete;
@property(nonatomic, copy)SelectedCompletionBlock block;

@end
