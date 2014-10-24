//
//  ShareViewController.h
//  ACME-Shopping
//
//  Created by fady on 13-11-5.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseViewController.h"
#import "TencentOAuth.h"
#import "DetailModel.h"

@interface ShareViewController : BaseViewController<TencentSessionDelegate, UITableViewDataSource, UITableViewDelegate>
{
	TencentOAuth *tencentOAuth;
	NSArray *permissions;
	
	UITableView *tblView;
	NSArray *arrFunctions;
	UIButton *btnClick;
}

@property(nonatomic, strong)DetailModel *model;

@end
