//
//  MynoteViewController.h
//  ACME-Shopping
//
//  Created by fady on 13-11-2.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseViewController.h"

@class NoteTableView;
@interface MynoteViewController : BaseViewController
@property (weak, nonatomic) IBOutlet NoteTableView *tableView;

@end
